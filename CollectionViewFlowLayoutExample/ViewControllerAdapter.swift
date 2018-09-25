//
//  ViewControllerAdapter.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import Foundation

class ViewControllerAdapter: NSObject {
    let booksModelController: BooksModelController

    init(booksModelController: BooksModelController) {
        self.booksModelController = booksModelController
    }
}

