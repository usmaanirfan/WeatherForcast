//
//  WeatherDetailCellPresenter.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit
class WeatherDetailCellPresenter : WeatherDetailCellPresenterProtocol {
    
    weak var view: ForecastDetailCellViewProtocol?
    var service: APIManagerProtocol
    var consolidatedWeather: ConsolidatedWeather
    var urlBuilder: URLConfigurationProtocol?
    var city: String
    var weatherDetail: String { return String(format: "H:%.1f°  L:%.1f°", consolidatedWeather.maxTemp,consolidatedWeather.minTemp)}
    var applicableDate: String { return self.consolidatedWeather.applicableDate}
        
    required init(with consolidatedWeather: ConsolidatedWeather, view: ForecastDetailCellViewProtocol, service: APIManagerProtocol, city: String) {
        self.city = city
        self.consolidatedWeather = consolidatedWeather
        self.view = view
        self.service = service
    }
    
    func fetchWeatherIcon() {
        guard let url = urlBuilder?.build(for: .icon, with: self.consolidatedWeather.weatherStateAbbr) else { return }
        service.fetchAssetsData(from: url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.view?.setWeatherImage(with: image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

