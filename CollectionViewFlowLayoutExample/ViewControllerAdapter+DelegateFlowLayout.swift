//
//  ViewController+DelegateFlowLayout.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

extension ViewControllerAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performUpdates(for: collectionView, at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).size.width
        let minColumnWidth = CGFloat(150.0)
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)

        return booksModelController.books[indexPath.item].isUpdated ? CGSize(width: cellWidth, height: 100) : CGSize(width: cellWidth, height: 70)
    }

    private func performUpdates(for collectionView:UICollectionView, at indexPath: IndexPath) {
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
    
}
