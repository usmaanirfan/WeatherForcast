//
//  APIManagerTestSute.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import XCTest
@testable import WeatherForcastDemo

class APIClientTests: XCTestCase {
    var session : URLSessionMock!
    var service : APIManager!
    var presenter : WeatherForecastPresenterProtocol!

    
    override func setUp() {
        session = URLSessionMock()
        service = APIManager(session: session)
    }
    
    override func tearDown() {
        
        
    }
    
    func testLocationDetailCityName() {
        let validURL = URL(string: "\(Constants.Endpoint.baseURL)/api/location/search/?query=London")!
        service.fetch(dataType: [LocationDetail].self, from: validURL) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.first?.title, "London", "Did not get the expected city.")
            default:
                XCTFail("The stubbed data did not return the current city of ")
            }
        }
    }
    
    func testWaetherDetailState() {
        let validURL = URL(string: "\(Constants.Endpoint.baseURL)/api/location/44418")!
        service.fetch(dataType: WeatherDetail.self, from: validURL) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.consolidatedWeather.first?.weatherStateName, "Heavy Rain", "Did not get the expected city.")
            default:
                XCTFail("The stubbed data did not return the current city of ")
            }
        }
    }
    
    func testCallsTheCorrectURL() {
        let validURL = URL(string: "\(Constants.Endpoint.baseURL)/api/location/44418")!
        service.fetch(dataType: WeatherDetail.self, from: validURL) { _ in
            XCTAssertEqual(self.session.urlInitiated, validURL)
        }
    }
    
    func testCallsTheCorrectURLIcon() {
        let validURL = URL(string: "\(Constants.Endpoint.baseURL)/static/img/weather/png/64/lc.png")!
        service.fetchAssetsData(from: validURL) { result in
            XCTAssertEqual(self.session.urlInitiated, validURL)
        }
    }

}
