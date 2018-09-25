//
//  ImageModelController.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 17.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class ImageProcessor {
    static func downsampleImage(fromData data: CFData, to pointSize: CGSize = CGSize(width: 200, height: 200), scale: CGFloat = 1.0) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data, imageSourceOptions) else { assert(false) }

        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
            ] as CFDictionary

        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { assert(false) }
        return UIImage(cgImage: downsampledImage)
    }
}
