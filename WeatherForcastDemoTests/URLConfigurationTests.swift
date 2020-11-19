//
//  URLConfigurationTests.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import XCTest
@testable import WeatherForcastDemo

class URLConfigurationTests: XCTestCase {
    var configurator: URLConfigurationProtocol!
    
    override func setUp() {
        configurator = URLConfiguration(baseURL: "https://www.metaweather.com")
    }
    
    override func tearDown() {
        configurator = nil
    }
    
    func testReturnsTheCorrectURLWhenGivenAWoeID() {
        let url = configurator.build(for: .woeid, with: "44418")
        
        let expectedURL = URL(string: "https://www.metaweather.com/api/location/44418")
        XCTAssertEqual(url, expectedURL)
    }
    
    func testReturnsTheCorrectURLWhenGivenACity() {
        let url = configurator.build(for: .locationsDetail, with: "London")
        
        let expectedURL = URL(string: "https://www.metaweather.com/api/location/search/?query=London")
        XCTAssertEqual(url, expectedURL)
    }
    
    func testReturnsTheCorrectURLWhenGivenAWeatherStateAbbreviation() {
        let url = configurator.build(for: .icon, with: "lc")
        let expectedURL = URL(string: "\(configurator.baseURLString)/static/img/weather/png/64/lc.png")
        XCTAssertEqual(url, expectedURL)
    }
}

