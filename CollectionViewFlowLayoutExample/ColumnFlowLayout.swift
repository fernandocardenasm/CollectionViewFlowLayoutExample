//
//  ColumnFlowLayout.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 05.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {

        super.prepare()
        //If the size of the cells do not change, we could sell all the methods here
//        guard let cv = collectionView else { return }

//        let availableWidth = cv.bounds.insetBy(dx: cv.layoutMargins.left, dy: cv.layoutMargins.top).size.width
//        let minColumnWidth = CGFloat(300.0)
//        let maxNumColumns = Int(availableWidth / minColumnWidth)
//        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
//
//        itemSize = CGSize(width: cellWidth, height: 70)

        sectionInset = UIEdgeInsets(top: self.minimumLineSpacing, left: 0.0, bottom: self.minimumLineSpacing, right: 0.0)

        sectionInsetReference = .fromSafeArea

    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let cv = collectionView else { return false }
        return !newBounds.size.equalTo(cv.bounds.size)
    }
}
