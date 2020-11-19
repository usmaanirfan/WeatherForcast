//
//  WeatherDetailCellPresenterSuite.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import XCTest
@testable import WeatherForcastDemo

class WeatherDetailCellPresenterSuite: XCTestCase, ForecastDetailCellViewProtocol{
    var presenter: WeatherDetailCellPresenterProtocol?
    private var urlSessionMock: URLSessionMock!
    var service : APImanagerMock!
    var expectation : XCTestExpectation?
    var consolidatedWeather : ConsolidatedWeather!
    
    override func setUp() {
        urlSessionMock = URLSessionMock()
        service = APImanagerMock(session: urlSessionMock)
        consolidatedWeather = ConsolidatedWeather(weatherStateName: "Heavy Rain", weatherStateAbbr: "hr", windDirectionCompass: "", applicableDate: "", minTemp: 1.0, maxTemp: 1.0, theTemp: 1.0, windSpeed: 1.0, windDirection: 1.0, airPressure: 1.0, humidity: 1, visibility: 1.0, predictability: 1)
        let presenterLocal = WeatherDetailCellPresenter(with: consolidatedWeather, view: self, service: service, city: "London")
        presenterLocal.urlBuilder = URLConfiguration(baseURL: Constants.Endpoint.baseURL)
        self.presenter = presenterLocal
    }
    
    override func tearDown() {
        
    }
    
    func testPresentWeatherForecastFromCity() {
        self.expectation = XCTestExpectation(description: "Delegate method should fire")
        presenter?.fetchWeatherIcon()
        self.wait(for: [self.expectation!], timeout: 0.1)
    }
        
    func setWeatherImage(with : UIImage) {
        self.expectation?.fulfill()
    }
    
}
