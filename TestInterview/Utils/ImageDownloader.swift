//
//  ImageRecord.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 10/04/22.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
    
}
class ImageDownloader {
    private var dataTask: URLSessionDataTask?
    
    func download(url: URL, callback: @escaping (UIImage?, Error?) -> Void) {
        cancel()
        dataTask = nil
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                DispatchQueue.main.async { [data] in
                    callback(UIImage(data: data), error)
                }
            }
        })
        dataTask?.resume()
    }
    
    func cancel() {
        self.dataTask?.cancel()
    }
}
