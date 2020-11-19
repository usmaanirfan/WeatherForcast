//
//  WeatherForecastPresenterProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation

protocol WeatherForecastPresenterProtocol {
    var view: ForecastDetailViewProtocol? { get set }
    var service: APIManagerProtocol { get set }
    init(view: ForecastDetailViewProtocol, service: APIManagerProtocol,city: String)
    func presentWeatherForecast()
    func getWeather(for woeid: Int,completion: @escaping (WeatherDetail) -> Void)
    func getLocationDetail(completion: @escaping ([LocationDetail]) -> Void)
    var city:String { get set }
}
