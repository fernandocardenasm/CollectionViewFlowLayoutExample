//
//  Book.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 24.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

struct Book {
    var title: String
    var isUpdated: Bool
    var color: UIColor
    var imageUrl: String?
    var image: UIImage?

    init(title: String = "Something great", isUpdated: Bool, color: UIColor, imageUrl: String? = nil) {
        self.title = title
        self.isUpdated = isUpdated
        self.color = color
        self.imageUrl = imageUrl
    }
}

class BooksModelController {

    let dataLoader: DataLoader

    private(set) var books: [Book] = [Book]()

    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }

    func updateBookStatus(at index: Int){
        books[index].isUpdated.toggle()
    }

    func loadBooks(completion: @escaping (Outcome<[Book], NSError>) -> Void) {
        books = createBooks()
        completion(.success(books))
    }

    func loadImagesFor(numberOfBooks: Int, completion: @escaping (Outcome<(Bool), NSError>) -> Void) {

        var numberOfIterations = 0

        for (index, book) in books.prefix(numberOfBooks).enumerated() {
            guard let urlString = book.imageUrl, let url = URL(string: urlString) else { return }

            dataLoader.loadData(from: url, completion: { [weak self] (outcome) in
                switch outcome {
                case .success(let data):
                    // When we implement getting a response with multiple images consider to use serialqueue.async to avoid overloading the CPUs.
                    self?.books[index].image = ImageProcessor.downsampleImage(fromData: data as CFData)
                    print("Book at Index: \(index)")
                case .error(let error):
                    print("|ERROR: \(error)")
                    completion(.error(error))
                }
                numberOfIterations += 1

                if numberOfIterations == numberOfBooks {
                    completion(.success(true))
                }
            })
        }
    }

    private func createBooks() -> [Book] {
        let books = [
            Book(title: "Hallo 1", isUpdated: false, color: .red, imageUrl: "https://picsum.photos/4000/4000/?image=1"),
            Book(title: "Hallo 2",isUpdated: false, color: .yellow, imageUrl: "https://picsum.photos/4000/4000/?image=2"),
            Book(title: "Hallo 3",isUpdated: false, color: .green, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/e/e6/Clocktower_Panorama_20080622_20mb.jpg"),
            Book(title: "Hallo 4",isUpdated: false, color: .gray, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg"),
            Book(title: "Hallo 5",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/4000/2000/?image=5"),
            Book(title: "Hallo 6",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/4000/2000/?image=6"),
            Book(title: "Hallo 7",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=7"),
            Book(title: "Hallo 8",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=8"),
            Book(title: "Hallo 9",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=9"),
            Book(title: "Hallo 10",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=10"),
            Book(title: "Hallo 11",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=11"),
            Book(title: "Hallo 12",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=12"),
            Book(title: "Hallo 13",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=13"),
            Book(title: "Hallo 14",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=14"),
            Book(title: "Hallo 15",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=15"),
            Book(title: "Hallo 16",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=16"),
            Book(title: "Hallo 17",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=17"),
            Book(title: "Hallo 18",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=18"),
            Book(title: "Hallo 19",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=19"),
            Book(title: "Hallo 20",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=20"),
            Book(title: "Hallo 21",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=21"),
            Book(title: "Hallo 22",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=22"),
            Book(title: "Hallo 23",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=23"),
            Book(title: "Hallo 24",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=24"),
            Book(title: "Hallo 25",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=25"),
            Book(title: "Hallo 26",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=26"),
            Book(title: "Hallo 27",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=27"),
            Book(title: "Hallo 28",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=28"),
            Book(title: "Hallo 29",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=29"),
            Book(title: "Hallo 30",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=30"),
            Book(title: "Hallo 31",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=31"),
            Book(title: "Hallo 32",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=32"),
            Book(title: "Hallo 33",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=33"),
            Book(title: "Hallo 34",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=34"),
            Book(title: "Hallo 35",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=35"),
            Book(title: "Hallo 36",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=36"),
            Book(title: "Hallo 37",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=37"),
            Book(title: "Hallo 38",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=38"),
            Book(title: "Hallo 39",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=39"),
            Book(title: "Hallo 40",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=40"),
            Book(title: "Hallo 41",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=41"),
            Book(title: "Hallo 42",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=42"),
            Book(title: "Hallo 43",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=43"),
            Book(title: "Hallo 44",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=44"),
            Book(title: "Hallo 45",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=45"),
            Book(title: "Hallo 46",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=46"),
            Book(title: "Hallo 47",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=47"),
            Book(title: "Hallo 48",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=48"),
            Book(title: "Hallo 49",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=49"),
            Book(title: "Hallo 50",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=50"),
            Book(title: "Hallo 51",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=51"),
            Book(title: "Hallo 52",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=52"),
            Book(title: "Hallo 53",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=53"),
            Book(title: "Hallo 54",isUpdated: false, color: .magenta, imageUrl: "https://picsum.photos/3000/2000/?image=54")
        ]
        return books
    }
}
