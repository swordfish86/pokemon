//
//  ConnectionManager.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 25/04/21.
//

import Foundation

enum RequestMethod {
    case post, get
}

enum RequestError: Error {
    case connectionFailed
}
typealias Parameter = (key: String, value: String)

final class ConnectionManager {
    class func request(from url: String,
                       params: Parameter...,
                       completion: @escaping (Result<Data, RequestError>) -> Void) {
        var paramsString = "?"
        var completeUrl  = url
        for param in params {
            paramsString.append("\(param.key)=\(param.value),")
        }
        paramsString.removeLast()
        completeUrl.append(contentsOf: paramsString)
        guard let urlComponents = URLComponents(string: completeUrl) else {
            completion(.failure(.connectionFailed))
            return
        }
        guard let url = urlComponents.url else {
            completion(.failure(.connectionFailed))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, !(error is URLError) else {
                    completion(.failure(.connectionFailed))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
}
