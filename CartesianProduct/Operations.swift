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

// `•` is option-8 (on my U.S. English keyboard layout)
infix operator • {
associativity left
}


/// 'Cartesian product' of two sequences
public func •<Left: SequenceType, Right: SequenceType>(lhs:Left, rhs:Right) -> [(Left.Generator.Element, Right.Generator.Element)] {
    return lhs.flatMap { x in  rhs.map { (x, $0) } }
}

// 'Cartesian product' of a Cartesian product and a collection. Meant to help manage type explosion.
public func •<Left: SequenceType, Right: SequenceType, A, B where
    Left.Generator.Element == (A, B)>(lhs:Left, rhs:Right) -> [(A, B, Right.Generator.Element)] {
        return lhs.flatMap { x in  rhs.map { (x.0, x.1, $0) } }
}

// 'Cartesian product' of a Cartesian product and a collection. Meant to help manage type explosion.
public func •<Left: SequenceType, Right: SequenceType, A, B, C where
    Left.Generator.Element == (A, B, C)>(lhs:Left, rhs:Right) -> [(A, B, C, Right.Generator.Element)] {
        return lhs.flatMap { x in  rhs.map { (x.0, x.1, x.2, $0) } }
}

// 'Cartesian product' of a Cartesian product and a collection. Meant to help manage type explosion.
public func •<Left: SequenceType, Right: SequenceType, A, B, C, D where
    Left.Generator.Element == (A, B, C, D)>(lhs:Left, rhs:Right) -> [(A, B, C, D, Right.Generator.Element)] {
        return lhs.flatMap { x in  rhs.map { (x.0, x.1, x.2, x.3, $0) } }
}

// Sure would love some templates about now.

// 'Cartesian product' of a Cartesian product and a collection. Meant to help manage type explosion.
public func •<Left: SequenceType, Right: SequenceType, A, B, C, D, E where
    Left.Generator.Element == (A, B, C, D, E)>(lhs:Left, rhs:Right) -> [(A, B, C, D, E, Right.Generator.Element)] {
        return lhs.flatMap { x in  rhs.map { (x.0, x.1, x.2, x.3, x.4, $0) } }
}
