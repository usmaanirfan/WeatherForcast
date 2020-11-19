//
//  APImanagerMock.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

@testable import WeatherForcastDemo

class APImanagerMock: APIManagerProtocol {
    typealias APIClientResult<T> = (Result<T, Error>) -> Void
    var session: URLSessionProtocol
    
    required init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: URL, completionHandler: @escaping APIClientResult<T>) {
        session.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else { return }
            
            do {
                let weatherResponse: T = try JSONDecoder().decode(T.self, from: jsonData)
                completionHandler(.success(weatherResponse))
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchAssetsData(from url: URL, completionHandler: @escaping DataResult) {
        if let image = UIImage(named: "ic_error_info.png") {
            if let data = image.pngData() {
                completionHandler(.success(data))
            }
        }
    }
}
