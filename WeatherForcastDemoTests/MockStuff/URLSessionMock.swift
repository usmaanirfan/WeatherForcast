//
//  URLSessionMock.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
@testable import WeatherForcastDemo

class URLSessionMock: URLSessionProtocol {
    var urlInitiated: URL?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var filePath : String? = Bundle.main.path(forResource: "LocationDetailData", ofType: "json")
        if url.absoluteString == "\(Constants.Endpoint.baseURL)/api/location/44418" {
            if let path = Bundle.main.path(forResource: "WeatherDetailData", ofType: "json") {
                filePath = path
            }
        } else if url.absoluteString == "\(Constants.Endpoint.baseURL)/api/location/search/?query=London" {
            if let path = Bundle.main.path(forResource: "LocationDetailData", ofType: "json") {
                filePath = path
            }
        }
        if let path = filePath {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                defer { completionHandler(data, nil, nil) }
                urlInitiated = url
            } catch {
                // handle error
            }
        } 
        return URLSessionDataTaskMock()
    }

}
