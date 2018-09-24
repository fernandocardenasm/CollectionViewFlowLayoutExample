//
//  ViewController.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 05.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    var flowLayout: ColumnFlowLayout!

    let imageModelController: ImageProcessor = ImageProcessor()
    let booksModelController: BooksModelController = BooksModelController(dataLoader: DataLoader())

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        setupActivityIndicator()

        loadBooks()
    }

    fileprivate func setupCollectionView() {
        // Do any additional setup after loading the view, typically from a nib.

        flowLayout = ColumnFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: String(describing: ColorCell.self))

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = .white
    }

//    let serialQueue = DispatchQueue(label: "Decode queue") // For a further implementation

    func loadBooks() {
        activityIndicator.startAnimating()
        booksModelController.loadBooks(completion: { [weak self] (outcome) in
            switch outcome {
            case .success(_):
                print("Entered here")
                self?.downloadImages(limit: 50)
            case .error(let error):
                print("|ERROR: \(error)")
            }
        })
    }
    func downloadImages(limit: Int) {
        booksModelController.loadImagesFor(numberOfBooks: 50, completion: { [weak self] (outcome) in
            switch outcome {
            case .success(_):
                print("Images were loaded")
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
            case .error(let error):
                print("|ERROR: \(error)")
            }
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksModelController.books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCell.self), for: indexPath) as! ColorCell
        
        cell.book = booksModelController.books[indexPath.item]

//        if cell.book?.isUpdated == true {
////            loadImage(in: cell)
//            cell.imageView.image = books[indexPath.item].image
//        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performUpdates(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).size.width
        let minColumnWidth = CGFloat(150.0)
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        return booksModelController.books[indexPath.item].isUpdated ? CGSize(width: cellWidth, height: 100) : CGSize(width: cellWidth, height: 70)
    }

    private func performUpdates(at indexPath: IndexPath) {
        // Update Data Source

        //Reload is conflictin with delete, that´s why it cannot be in the same performBatchUpdates
        //We can set the performBazchUpdates inside of performWithoutAnimation for no animation
        UIView.performWithoutAnimation {
            collectionView.performBatchUpdates({
                booksModelController.updateBookStatus(at: indexPath.item)
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

//            let movedBook = books[indexPath.item]
//            books.remove(at: indexPath.item)
//            books.insert(movedBook, at: 0)
//
//            collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
        })
    }

//    private func loadImage(in cell: ColorCell){
//        guard let imageUrl = cell.book?.imageUrl else { assert(false) }
//        guard let url = URL(string: imageUrl) else { assert(false) }
//
//        if let imageFromCache = imageModelController.imageCache.object(forKey: imageUrl as NSString) {
//            cell.imageView.image = imageFromCache
//        }
//        imageModelController.loadData(fromURL: url) { [weak self] (outcome) in
//            switch outcome {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    guard !cell.imageView.bounds.size.equalTo(CGSize.zero) else { return }
//                    guard cell.traitCollection.displayScale != 0 else { return }
//                    let imageToCache = ImageProcessor.downsampleImage(fromData: data as CFData, to: cell.imageView.bounds.size, scale: cell.traitCollection.displayScale)
//                    self?.imageModelController.imageCache.setObject(imageToCache, forKey: imageUrl as NSString)
//                    cell.imageView.image = imageToCache
//                }
//            case .error(let error):
//                print("|ERROR: \(error)")
//            }
//        }
//    }
}

class ColorCell: UICollectionViewCell {

    var noImageConstraints: [NSLayoutConstraint]!
    var imageConstraints: [NSLayoutConstraint]!

    var book: Book? {
        didSet {
            guard let book = book else { return }
            imageView.image = nil
            titleLabel.text = book.title
            titleLabel.backgroundColor = book.color
            book.isUpdated ? updateSetupForImage(book: book) : updateSetupForNoImage()
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

    func updateSetupForNoImage() {
        guard let constraint = noImageConstraints.first else { return }
        if !constraint.isActive {
            imageConstraints.forEach { $0.isActive = false }
            noImageConstraints.forEach { $0.isActive = true }
        }
    }

    func updateSetupForImage(book: Book) {
        guard let constraint = imageConstraints.first else { return }
        if !constraint.isActive {
            imageConstraints.forEach { $0.isActive = true }
            noImageConstraints.forEach { $0.isActive = false }
        }
        imageView.image = book.image
    }
}

