//
//  Operations.swift
//  CartesianProducts
//
//  Created by TJ Usiyan on 2/18/15.
//  Copyright (c) 2015 Buttons and Lights LLC. All rights reserved.
//

// The goal
// for case … in cartProd(cartProd(seq1, seq2), seq3) //  operator for cartProd?

// MARK: -

/// 'Cartesian product' of sequence and collection (right must be collection for 'replayability')
public func cartProd<Left: SequenceType, Right: CollectionType>(lhs:Left, rhs:Right) -> CartesianProductOf<Left, Right> {
    return CartesianProductOf(leftCollection: lhs, rightCollection: rhs)
}

// 'Cartesian product' of a Cartesian product and a collection. Meant to help manage type explosion.
public func cartProd<A : SequenceType, B : SequenceType, Right: CollectionType> (lhs:CartesianProductOf<A, B>, rhs:Right) -> MappedSequence<CartesianProductOf<CartesianProductOf<A, B>, Right>, (A.Generator.Element, B.Generator.Element, Right.Generator.Element)> {
        let it:MappedSequence<CartesianProductOf<CartesianProductOf<A, B>, Right>, (A.Generator.Element, B.Generator.Element, Right.Generator.Element)> = MappedSequence(source: cartProd(lhs, rhs: rhs)) { (leftValue, rightValue) in (leftValue.0, leftValue.1, rightValue)
        }
        return it
}
