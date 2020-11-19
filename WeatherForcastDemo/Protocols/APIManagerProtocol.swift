//
//  APIManagerProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    typealias APIManagerResult<T> = (Result<T, Error>) -> Void
    typealias DataResult = (Result<Data, Error>) -> Void
    var session: URLSessionProtocol { get set }
    init(session: URLSessionProtocol)
    func fetch<T: Decodable>(dataType: T.Type, from url: URL, completionHandler: @escaping APIManagerResult<T>)
    func fetchAssetsData(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
}
