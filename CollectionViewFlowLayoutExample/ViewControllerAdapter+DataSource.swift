//
//  BookViewController+DataSource.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

extension ViewControllerAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksModelController.books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeCell.self), for: indexPath) as! WelcomeCell

        let book = booksModelController.books[indexPath.item]

        cell.imageView.image = nil
        cell.titleLabel.text = book.title
        cell.titleLabel.backgroundColor = book.color
        book.isUpdated ? cell.updateSetupForImage(with: book.image) : cell.updateSetupForNoImage()

        return cell
    }
}
