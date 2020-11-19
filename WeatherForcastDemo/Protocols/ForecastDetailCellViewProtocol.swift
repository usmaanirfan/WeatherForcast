//
//  ForecastDetailCellViewProtocol.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

protocol ForecastDetailCellViewProtocol : class {
    var presenter: WeatherDetailCellPresenterProtocol? { get set }
    func setWeatherImage(with: UIImage)
}
