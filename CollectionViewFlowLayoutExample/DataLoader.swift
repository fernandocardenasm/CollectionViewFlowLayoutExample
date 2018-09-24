//
//  DataLoader.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 24.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import Foundation

class DataLoader {
    
    private let session: URLSession = URLSession(configuration: .default)

    func loadData(from url: URL, completion: @escaping (Outcome<Data, NSError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(.success(data))
            }
            else if let error = error {
                completion(.error(error as NSError))
            }
        }
        task.resume()
    }
}
