//
//  WeatherDetailCellPresenterProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
protocol WeatherDetailCellPresenterProtocol {
    var view: ForecastDetailCellViewProtocol? { get set }
    var service: APIManagerProtocol { get set }
    init(with consolidatedWeather : ConsolidatedWeather, view: ForecastDetailCellViewProtocol, service: APIManagerProtocol,city: String)
    func fetchWeatherIcon()
    var city:String { get set }
}
