//
//  WeatherForecastPresenter.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation

class WeatherForecastPresenter: WeatherForecastPresenterProtocol {
    weak var view: ForecastDetailViewProtocol?
    var service: APIManagerProtocol
    var urlBuilder: URLConfigurationProtocol?
    var city:String
    
    required init(view: ForecastDetailViewProtocol, service: APIManagerProtocol,city: String) {
        self.view = view
        self.service = service
        self.city = city
    }
    
    func presentWeatherForecast() {
        self.getLocationDetail() { locationDetail in
            guard let woeid = locationDetail.first?.woeid else { return }
            self.getWeather(for: woeid) { weatherDetail in
                self.view?.setWeatherDetail(weatherResponse: weatherDetail)
            }
        }
    }
    
    func getLocationDetail(completion: @escaping ([LocationDetail]) -> Void) {
        let query = self.city
        guard let url = urlBuilder?.build(for: .locationsDetail, with: query) else { return }
        
        service.fetch(dataType: [LocationDetail].self, from: url) { result in
            switch result {
            case .success(let locations):
                completion(locations)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeather(for woeid: Int, completion: @escaping (WeatherDetail) -> Void) {
        guard let url = urlBuilder?.build(for: .woeid, with: String(woeid)) else { return }
        
        service.fetch(dataType: WeatherDetail.self, from: url) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
