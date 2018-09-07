//
//  ImageTask.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 07.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class ImageTask {
    let position: Int
    let url: URL
    let session: URLSession
    let delegate: ImageTaskDownloadDelegate

    var image: UIImage?

    private var task: URLSessionDownloadTask?
    private var resumeData: Data?

    private var isDownloading = false
    private var isFinishedDownloading = false

    init(position: Int, url: URL, session: URLSession, delegate: ImageTaskDownloadDelegate) {
        self.position = position
        self.url = url
        self.session = session
        self.delegate = delegate
    }

    func resume() {
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true

            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            }
            else {
                task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
            }
        }
    }

    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { [weak self] (data) in
                self?.resumeData = data
            })
            isDownloading = false
        }
    }
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {

        if let error = error {
            print("Error donwloading: ", error)
            return
        }

        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }

        DispatchQueue.main.async { [weak self] in
            self?.image = image
            guard let position = self?.position else { return }
            self?.delegate.imageDownloaded(position: position)
        }

        isFinishedDownloading = true
    }
}

protocol ImageTaskDownloadDelegate {
    func imageDownloaded(position: Int)
}
