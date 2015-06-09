//
//  CartesianProduct.swift
//  TonalKit
//
//  Created by TJ Usiyan on 2/14/15.
//  Copyright (c) 2015 buttons-and-lights. All rights reserved.
//

public struct CartesianProductOf<LeftCollectionType: SequenceType, RightCollectionType: CollectionType> : SequenceType {
    public typealias Generator = CartesianProductGenerator<LeftCollectionType, RightCollectionType>

    private let leftCollection:LeftCollectionType
    private let rightCollection:RightCollectionType

    public func generate() -> Generator {
        return CartesianProductGenerator(leftCollection: leftCollection, rightCollection: rightCollection)
    }

    public init(leftCollection:LeftCollectionType, rightCollection:RightCollectionType) {
        self.leftCollection = leftCollection
        self.rightCollection = rightCollection
    }
}

public struct CartesianProductGenerator<LeftCollectionType: SequenceType, RightCollectionType: CollectionType> : GeneratorType {

    public typealias LeftElement = LeftCollectionType.Generator.Element
    public typealias RightElement = RightCollectionType.Generator.Element

    public typealias Element = (left:LeftElement, right:RightElement)


    internal private(set) var rightCollection: RightCollectionType
    internal private(set) var leftGenerator: LeftCollectionType.Generator
    internal private(set) var rightGenerator: RightCollectionType.Generator

    private var left:LeftCollectionType.Generator.Element?

    init(leftCollection:LeftCollectionType, rightCollection:RightCollectionType) {
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
