//
//  ForecastDetailViewProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
protocol ForecastDetailViewProtocol : class {
    var presenter: WeatherForecastPresenterProtocol? { get set }
    func setWeatherDetail(weatherResponse: WeatherDetail)
}
