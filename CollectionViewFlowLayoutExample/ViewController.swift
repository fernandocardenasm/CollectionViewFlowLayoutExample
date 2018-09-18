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

    var imageModelController: ImageModelController = ImageModelController()

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    var books: [Book] = [
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

        view.addSubview(activityIndicator)

        activityIndicator.frame = view.bounds

        activityIndicator.startAnimating()

        downloadImages(limit: 50)
    }

//    let serialQueue = DispatchQueue(label: "Decode queue") // For a further implementation

    func downloadImages(limit: Int) {
        var count = 0
        for index in 0..<limit {
            guard let imageUrl = books[index].imageUrl else { assert(false) }
            guard let url = URL(string: imageUrl) else { assert(false) }

            imageModelController.loadData(fromURL: url) { [weak self] (outcome) in
                count += 1
                switch outcome {
                case .success(let data):
                    //When we implement getting a response with multiple images consider to use serialqueue.async to avoid overloading the CPUs.
                    self?.books[index].image = ImageProcessor.downsampleImage(fromData: data as CFData)
                    print("Index \(index)")
                case .error(let error):
                    print("|ERROR: \(error)")
                }
                if count == limit {
                    print("Finished")
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCell.self), for: indexPath) as! ColorCell
        
        cell.book = books[indexPath.item]

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

        let availableWidth = collectionView.bounds.insetBy(dx: collectionView.layoutMargins.left, dy: collectionView.layoutMargins.top).size.width
        let minColumnWidth = CGFloat(200.0)
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        return books[indexPath.item].isUpdated ? CGSize(width: cellWidth, height: 100) : CGSize(width: cellWidth, height: 70)
    }

    private func performUpdates(at indexPath: IndexPath) {
        // Update Data Source

        //Reload is conflictin with delete, that´s why it cannot be in the same performBatchUpdates
        //We can set the performBazchUpdates inside of performWithoutAnimation for no animation
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

//            let movedBook = books[indexPath.item]
//            books.remove(at: indexPath.item)
//            books.insert(movedBook, at: 0)
//
//            collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
        })
    }

    private func loadImage(in cell: ColorCell){
        guard let imageUrl = cell.book?.imageUrl else { assert(false) }
        guard let url = URL(string: imageUrl) else { assert(false) }

        if let imageFromCache = imageModelController.imageCache.object(forKey: imageUrl as NSString) {
            cell.imageView.image = imageFromCache
        }
        imageModelController.loadData(fromURL: url) { [weak self] (outcome) in
            switch outcome {
            case .success(let data):
                DispatchQueue.main.async {
                    guard !cell.imageView.bounds.size.equalTo(CGSize.zero) else { return }
                    guard cell.traitCollection.displayScale != 0 else { return }
                    let imageToCache = ImageProcessor.downsampleImage(fromData: data as CFData, to: cell.imageView.bounds.size, scale: cell.traitCollection.displayScale)
                    self?.imageModelController.imageCache.setObject(imageToCache, forKey: imageUrl as NSString)
                    cell.imageView.image = imageToCache
                }
            case .error(let error):
                print("|ERROR: \(error)")
            }
        }
    }
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

