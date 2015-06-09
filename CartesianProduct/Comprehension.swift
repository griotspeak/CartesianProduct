//
//  CartesianProduct.swift
//  TonalKit
//
//  Created by TJ Usiyan on 2/14/15.
//  Copyright (c) 2015 buttons-and-lights. All rights reserved.
//

public struct CartesianProductOf<LSeq: SequenceType, RCol: CollectionType> : SequenceType {
    public typealias Generator = CartesianProductGenerator<LSeq, RCol>

    private let leftCollection:LSeq
    private let rightCollection:RCol

    public func generate() -> Generator {
        return CartesianProductGenerator(leftCollection: leftCollection, rightCollection: rightCollection)
    }

    public init(leftCollection:LSeq, rightCollection:RCol) {
        self.leftCollection = leftCollection
        self.rightCollection = rightCollection
    }
}

public struct CartesianProductGenerator<LSeq: SequenceType, RCol: CollectionType> : GeneratorType {

    public typealias LeftElement = LSeq.Generator.Element
    public typealias RightElement = RCol.Generator.Element

    public typealias Element = (left:LeftElement, right:RightElement)


    internal private(set) var rightCollection: RCol
    internal private(set) var leftGenerator: LSeq.Generator
    internal private(set) var rightGenerator: RCol.Generator

    private var left:LSeq.Generator.Element?

    init(leftCollection:LSeq, rightCollection:RCol) {
        self.rightCollection = rightCollection
        self.leftGenerator = leftCollection.generate()
        self.rightGenerator = rightCollection.generate()

        self.left = leftGenerator.next()
    }

    mutating public func next() -> Element? {
        if let theLeft = self.left {
            if let theRight = self.rightGenerator.next() {
                return (theLeft, theRight)
            } else {
                // reset right and bump left
                self.rightGenerator = rightCollection.generate()
                self.left = leftGenerator.next()
                return next()
            }
        } else {
            return nil
        }
    }
}
