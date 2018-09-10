//
//  UIImage+LoadImageAsync.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 10.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageUsing(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error != nil {
                print("|ERROR: \(String(describing: error))")
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
