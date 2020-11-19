//
//  ForecastDetailViewControllerTestSuite.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherForcastDemo

class ForecastDetailViewControllerTestSuite: XCTestCase {
    
    var forecastDetailViewController: ForecastDetailViewController!
    var weatherResponse : WeatherDetail?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.forecastDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForecastDetailViewControllerID") as? ForecastDetailViewController
        if let path = Bundle.main.path(forResource: "WeatherDetailData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.weatherResponse = try JSONDecoder().decode(WeatherDetail.self, from: data)
            } catch {
                // handle error
            }
        }
        self.forecastDetailViewController.weatherResponse = self.weatherResponse
        _ = forecastDetailViewController.view

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReorderGroupsVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(self.forecastDetailViewController.tableView)
    }
    
    func testViewDidLoad_SetsTableViewDataSource(){
        XCTAssertNotNil(self.forecastDetailViewController.tableView.dataSource)
    }

    func testViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(self.forecastDetailViewController.tableView.delegate)
    }
    
    func testViewNumberOfSections() {
        XCTAssertEqual(self.forecastDetailViewController.tableView.numberOfSections, 2)
    }
    
    func testViewNumberOfRow() {
        XCTAssertEqual(self.forecastDetailViewController.tableView.numberOfRows(inSection: 0), 1)
    }
        
    func testViewnavigationItemNotNil() {
        XCTAssertNotNil(self.forecastDetailViewController.navigationItem)
    }
}
