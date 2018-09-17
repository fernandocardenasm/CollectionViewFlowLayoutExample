//
//  UIImage+LoadImageAsync.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 10.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsing(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        }
        else {
            layoutIfNeeded()
            guard !bounds.size.equalTo(CGSize.zero) else { return }
            let imageViewSize = bounds.size
            guard !traitCollection.displayScale.isEqual(to: 0) else { return }
            let displayScale = traitCollection.displayScale
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print("|ERROR: \(String(describing: error))")
                    return
                }
                guard let data = data else { return }

                //The app could crash when we try to downsample an Image for a cell that it is not visible anymore because the UIImageView bound.size are zero.

                DispatchQueue.main.async {
//                    guard let imageViewSize = self?.bounds.size, !imageViewSize.equalTo(CGSize.zero) else { return }
//                    guard let displayScale = self?.traitCollection.displayScale else { return }
                    guard let imageToCache = self?.downsampleImage(fromData: data as CFData, to: imageViewSize, scale: displayScale) else { return }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    self?.image = imageToCache
                }
            }
            task.resume()
        }
    }

    private func downsampleImage(fromData data: CFData, to pointSize: CGSize, scale: CGFloat) -> UIImage {
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
