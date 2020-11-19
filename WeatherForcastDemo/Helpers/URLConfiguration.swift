//
//  URLConfiguration.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
enum Endpoint: String {
    case icon = "/static/img/weather/png/64"
    case locationsDetail = "/api/location/search/?query="
    case woeid = "/api/location"
}

class URLConfiguration: URLConfigurationProtocol {
    var baseURLString: String
    
    required init(baseURL: String) {
        self.baseURLString = baseURL
    }
    
    func build(for endpoint: Endpoint, with query: String) -> URL? {
        switch endpoint {
        case.icon:
            let strURL = "\(baseURLString)\(endpoint.rawValue)/\(query).png"
            let encodedStr = strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return URL(string: encodedStr!)
        case .locationsDetail:
            let strURL = "\(baseURLString)\(endpoint.rawValue)\(query)"
            let encodedStr = strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return URL(string: encodedStr!)
        case .woeid:
            let strURL = "\(baseURLString)\(endpoint.rawValue)/\(query)"
            let encodedStr = strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return URL(string: encodedStr!)
        }
    }
}
