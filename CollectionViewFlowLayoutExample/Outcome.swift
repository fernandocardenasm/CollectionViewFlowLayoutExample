//
//  Outcome.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import Foundation

enum Outcome<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}
