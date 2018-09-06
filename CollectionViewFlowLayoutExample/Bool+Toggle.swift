//
//  Bool+Toggle.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 06.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

extension Bool {
    /// Equivalent to `someBool = !someBool`
    ///
    /// Useful when operating on long chains:
    ///
    ///    myVar.prop1.prop2.enabled.toggle()
    mutating func toggle() {
        self = !self
    }
}
