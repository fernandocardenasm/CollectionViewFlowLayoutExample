//
//  ImageModelController.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 17.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class ImageTask {
    var urlString: String?
    var data: NSData?

    var isDownloading: Bool = false
    var isDownloaded: Bool = false

    typealias Handler = (Outcome<UIImage, NSError>) -> Void


    func pause() {
        if isDownloading && !isDownloaded {
        }
    }
}

class ImageProcessor {
    static func downsampleImage(fromData data: CFData, to pointSize: CGSize, scale: CGFloat) -> UIImage {
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

class ImageModelController {

    let imageCache = NSCache<NSString, UIImage>()
    var imageTasks: [ImageTask] = []

    let session: URLSession = URLSession()
    private var task: URLSessionDataTask?

    func loadImage(fromURLString urlString: String, to pointSize: CGSize, scale: CGFloat) {

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        }
        else {
            guard let url = URL(string: urlString) else { return }

            guard pointSize.equalTo(CGSize.zero) else { return }
            let imageViewSize = pointSize
            guard scale.isEqual(to: 0) else { return }
            let displayScale = scale

            task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
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
            task?.resume()
        }
    }

    func pauseDownload(){

    }
}

enum Outcome<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}
