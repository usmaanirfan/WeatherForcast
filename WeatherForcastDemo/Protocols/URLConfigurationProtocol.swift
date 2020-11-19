//
//  URLConfigurationProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation

protocol URLConfigurationProtocol {
    var baseURLString: String { get set }
    init(baseURL: String)
    func build(for endpoint: Endpoint, with query: String) -> URL?
}

