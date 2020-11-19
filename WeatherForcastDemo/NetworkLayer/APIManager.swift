//
//  APIManager.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation

class APIManager : APIManagerProtocol{
    typealias APIManagerResult<T> = (Result<T, Error>) -> Void
    var session: URLSessionProtocol
    
    required init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: URL, completionHandler: @escaping APIManagerResult<T>) {
        self.session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error!))
                return
            }
                        
            do {
                let decodedJSON: T = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedJSON))
            } catch let error {
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    func fetchAssetsData(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(error!))
                return
            }
            
            completionHandler(.success(data))
            return
        }.resume()
    }

}
