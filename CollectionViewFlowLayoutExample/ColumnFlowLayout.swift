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

        guard let cv = collectionView else { return }

        print("Hello")

        let availableWidth = cv.bounds.insetBy(dx: cv.layoutMargins.left, dy: cv.layoutMargins.top).size.width
        let minColumnWidth = CGFloat(300.0)
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)

        itemSize = CGSize(width: cellWidth, height: 70.0)

        sectionInset = UIEdgeInsets(top: self.minimumLineSpacing, left: 0.0, bottom: 0.0, right: 0.0)

        sectionInsetReference = .fromSafeArea
    }

}
