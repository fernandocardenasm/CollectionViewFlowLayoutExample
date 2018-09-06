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

    var books: [Book] = [Book(title: "Hallo 1", isUpdated: false, color: .red),
                         Book(title: "Hallo 2",isUpdated: false, color: .yellow, image: UIImage(named: "auto")),
                         Book(title: "Hallo 3",isUpdated: false, color: .green),
                         Book(title: "Hallo 4",isUpdated: false, color: .gray),
                         Book(title: "Hallo 5",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 6",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 7",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 8",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 9",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 10",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 11",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 12",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 13",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 14",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 15",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 16",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 17",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 18",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 19",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 20",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 21",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 22",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 23",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 24",isUpdated: false, color: .magenta),
                         Book(title: "Hallo 25",isUpdated: false, color: .magenta, image: UIImage(named: "auto"))]

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
//        cell.titleLabel.text = ""
        cell.imageView.image = nil
        cell.book = books[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Yes")
        performUpdates(at: indexPath)
    }

    func performUpdates(at indexPath: IndexPath) {
        // Update Data Source

        //Reload is conflictin with delete, that´s why it cannot be in the same performBatchUpdates
        UIView.performWithoutAnimation {
            collectionView.performBatchUpdates({
                books[indexPath.item].isUpdated.toggle()
                collectionView.reloadItems(at: [indexPath])
            })
        }

        collectionView.performBatchUpdates({

            /*
             Example implementation and considerations
             */

//            //We have two updates_
//            // - delete item at index 2
//            // - Move item at index 3 to index 0
//
//            // becomes...
//
//            // delete item at index 2
//            // delete item at index 3
//            // insert item from index 3 at index 0
//
//            let movedBook = books[3]
//
//            //remove from descending order
//            books.remove(at: 3)
//            books.remove(at: 2)
//
//            //insert ascending order
//            books.insert(movedBook, at: 0)
//
//            //Update Collection View
//            //From the data source we only deleted one, that´s why only effect is applied here.
//            collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)])
//            collectionView.moveItem(at: IndexPath(item: 3, section: 0), to: IndexPath(item: 0, section: 0))


            // Real implementation
            //In this case the batchUpdates is not necessary because we are only one action to animate

            let movedBook = books[indexPath.item]
            books.remove(at: indexPath.item)
            books.insert(movedBook, at: 0)

            collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
        })
    }
}

class ColorCell: UICollectionViewCell {

    var noImageConstraints: [NSLayoutConstraint]!
    var imageConstraints: [NSLayoutConstraint]!

    var book: Book? {
        didSet {
            guard let book = book else { return }
            book.isUpdated ? updateConstraintsForImage(book: book) : updateConstraintsForNoImage()
            titleLabel.text = book.title
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Something great"
        label.backgroundColor = .lightGray
        return label
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {

        addSubview(titleLabel)
        addSubview(imageView)

        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        noImageConstraints = [titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
        noImageConstraints.forEach { $0.isActive = true }

        imageConstraints = [imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)]
    }

    func updateConstraintsForNoImage() {
        guard let constraint = noImageConstraints.first else { return }
        if !constraint.isActive {
            noImageConstraints.forEach { $0.isActive = true }
            imageConstraints.forEach { $0.isActive = false }
        }
    }

    func updateConstraintsForImage(book: Book) {
        imageView.image = book.image
        guard let constraint = imageConstraints.first else { return }
        if !constraint.isActive {
            noImageConstraints.forEach { $0.isActive = false }
            imageConstraints.forEach { $0.isActive = true }
        }
    }
}

struct Book {
    var title: String
    var isUpdated: Bool
    var color: UIColor
    var image: UIImage?

    init(title: String = "Something great", isUpdated: Bool, color: UIColor, image: UIImage? = nil) {
        self.title = title
        self.isUpdated = isUpdated
        self.color = color
        self.image = image
    }
}

