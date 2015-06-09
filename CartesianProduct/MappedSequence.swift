//
//  MappedSequence.swift
//  CartesianProducts
//
//  Created by TJ Usiyan on 2/18/15.
//  Copyright (c) 2015 Buttons and Lights LLC. All rights reserved.
//

// MARK: - MappedSequence
public struct MappedSequence<Source : SequenceType, Output> {
    private let source:Source
    private let function:Generator.Function

    public init(source:Source, function:Generator.Function) {
        self.source = source
        self.function = function
    }
}
extension MappedSequence : SequenceType {
    public typealias Generator = MappedSequenceGenerator<Source, Output>

    public func generate() -> Generator {
        return Generator(source:source.generate(), function:function)
    }
}

// MARK: - MappedSequenceGenerator

public struct MappedSequenceGenerator<Source : SequenceType, Output> {
    private var source:Source.Generator
    private let function:Function

    private init(source:Source.Generator, function:Function) {
        self.source = source
        self.function = function
    }
}

extension MappedSequenceGenerator : GeneratorType {
    public typealias Element = Output
    public typealias Function = Source.Generator.Element -> Output

    public mutating func next() -> Output? {
        return source.next().map {
            self.function($0)
        }
    }
}
