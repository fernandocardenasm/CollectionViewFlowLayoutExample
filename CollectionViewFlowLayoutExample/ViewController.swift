//
//  ViewController.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 05.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    private var flowLayout: ColumnFlowLayout!
    private var collectionView: UICollectionView!

    let booksModelController: BooksModelController = BooksModelController(dataLoader: DataLoader())
    private var viewControllerAdapter: ViewControllerAdapter!

    private let activityIndicator = UIActivityIndicatorView(style: .gray)

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

        collectionView.register(WelcomeCell.self, forCellWithReuseIdentifier: String(describing: WelcomeCell.self))

        viewControllerAdapter = ViewControllerAdapter(booksModelController: booksModelController)
        collectionView.dataSource = viewControllerAdapter
        collectionView.delegate = viewControllerAdapter
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
                print("Start Loading Images")
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
