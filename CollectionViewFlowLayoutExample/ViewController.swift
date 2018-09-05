//
//  ViewController.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 05.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    var flowLayout: ColumnFlowLayout!

    var books: [Book] = [Book(isUpdated: false, color: .red), Book(isUpdated: false, color: .yellow), Book(isUpdated: false, color: .green), Book(isUpdated: false, color: .gray), Book(isUpdated: false, color: .magenta)]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        flowLayout = ColumnFlowLayout()

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .blue
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)

        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: String(describing: ColorCell.self))

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCell.self), for: indexPath) as! ColorCell
        cell.book = books[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Yes")
        performUpdates()
    }

    func performUpdates() {
        // Update Data Source

        //Reload is conflictin with delete, that´s why it cannot be in the same performBatchUpdates
        UIView.performWithoutAnimation {
            collectionView.performBatchUpdates({
                books[3].isUpdated = true
                collectionView.reloadItems(at: [IndexPath(item: 3, section: 0)])
            })
        }

        collectionView.performBatchUpdates({
            //We have two updates_
            // - delete item at index 2
            // - Move item at index 3 to index 0

            // becomes...

            // delete item at index 2
            // delete item at index 3
            // insert item from index 3 at index 0

            let movedBook = books[3]

            //remove from descending order
            books.remove(at: 3)
            books.remove(at: 2)

            //insert ascending order
            books.insert(movedBook, at: 0)

            //Update Collection View
            //From the data source we only deleted one, that´s why only effect is applied here.
            collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)])
            collectionView.moveItem(at: IndexPath(item: 3, section: 0), to: IndexPath(item: 0, section: 0))
        })
    }
}

class ColorCell: UICollectionViewCell {

    var book: Book? {
        didSet {
            guard let book = book else { return }
            backgroundColor = book.isUpdated ? .black : book.color
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .gray
    }
}

struct Book {
    var isUpdated: Bool
    var color: UIColor
}

