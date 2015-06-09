//
//  Operations.swift
//  CartesianProducts
//
//  Created by TJ Usiyan on 2/18/15.
//  Copyright (c) 2015 Buttons and Lights LLC. All rights reserved.
//

// The goal
// for … in { … } |<-- filter(cartProd(cartProd(seq1, seq2), seq3)) // probably an operator for cartProd

infix operator |<-- {
associativity none
precedence 75
}

public func |<--<S : SequenceType, Input, Output where S.Generator.Element == Input>(transform:Input -> Output, source:S) -> MappedSequence<S, Output> {
    return MappedSequence(source: source, function: transform)
}

// MARK: -

/// 'Cartesian product' of two sequences
public func cartProd<LeftType: SequenceType, RightType: CollectionType>(lhs:LeftType, rhs:RightType) -> CartesianProductOf<LeftType, RightType> {
    return CartesianProductOf(leftCollection: lhs, rightCollection: rhs)
}

// 'Cartesian product' of two sequences
public func cartProd<A : SequenceType, B : SequenceType, RightType: CollectionType>
    (lhs:CartesianProductOf<A, B>, rhs:RightType) ->
    MappedSequence<CartesianProductOf<CartesianProductOf<A, B>, RightType>, (A.Generator.Element, B.Generator.Element, RightType.Generator.Element)> {
        let it:MappedSequence<CartesianProductOf<CartesianProductOf<A, B>, RightType>, (A.Generator.Element, B.Generator.Element, RightType.Generator.Element)> = MappedSequence(source: cartProd(lhs, rhs: rhs)) { (leftValue, rightValue) in (leftValue.0, leftValue.1, rightValue)
        }
        return it
}
