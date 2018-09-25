//
//  BooksModelControllerTests.swift
//  CollectionViewFlowLayoutExampleTests
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import XCTest
import UIKit
@testable import CollectionViewFlowLayoutExample

class BooksModelControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadBooksWithImages(){
        let dataLoader = MockDataLoader()
        let sut = BooksModelController(dataLoader: dataLoader)

        let expBooks = expectation(description: "loadBooks")
        var booksAux: [Book] = [Book]()
        sut.loadBooks { (outcome) in
            switch outcome {
            case .success(let books):
                booksAux = books
                expBooks.fulfill()
            case .error(_):
                XCTAssert(false)
            }
        }
        wait(for: [expBooks], timeout: 1)
        XCTAssert(sut.books == booksAux)

        let expImages = expectation(description: "loadImages")

        var loadImagesValue = false

        sut.loadImagesFor(numberOfBooks: 1) { (outcome) in
            switch outcome {
            case .success(let value):
                loadImagesValue = value
                expImages.fulfill()
            case .error(_):
                XCTAssert(false)
            }
        }
        wait(for: [expImages], timeout: 1)
        XCTAssert(loadImagesValue == true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension BooksModelControllerTests {
    class MockDataLoader: DataLoader {
        override func loadData(from url: URL, completion: @escaping (Outcome<Data, NSError>) -> Void) {
            guard let data = UIImage(named: "auto")?.pngData() else { return }
            completion(.success(data))
        }
    }
}
