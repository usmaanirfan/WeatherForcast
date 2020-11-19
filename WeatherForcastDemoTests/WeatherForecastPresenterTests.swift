//
//  WeatherForecastPresenterTests.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import XCTest
@testable import WeatherForcastDemo
class WeatherForecastPresenterTests: XCTestCase, ForecastDetailViewProtocol{
    var presenter: WeatherForecastPresenterProtocol?
    private var urlSessionMock: URLSessionMock!
    var service : APIManager!
    var expectation : XCTestExpectation?
    
    override func setUp() {
        urlSessionMock = URLSessionMock()
        service = APIManager(session: urlSessionMock)
        let presenterLocal = WeatherForecastPresenter(view: self, service: service, city: "London")
        presenterLocal.urlBuilder = URLConfiguration(baseURL: Constants.Endpoint.baseURL)
        self.presenter = presenterLocal
    }
    
    override func tearDown() {
        
    }
    
    func testPresentWeatherForecastFromCity() {
        self.expectation = XCTestExpectation(description: "Delegate method should fire")
        presenter?.presentWeatherForecast()
        self.wait(for: [self.expectation!], timeout: 0.1)
    }
    
    func  testgetWeatherForecastFromId() {
        presenter?.getWeather(for: 44418) { weatherDetail in
            XCTAssertEqual(weatherDetail.consolidatedWeather.first?.weatherStateName, "Heavy Rain")
        }
    }
    
    func setWeatherDetail(weatherResponse: WeatherDetail) {
        if weatherResponse.title == "London" {
            self.expectation?.fulfill()
        }
    }
}
