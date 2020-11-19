//
//  CityListViewControllerTestSuite.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherForcastDemo

class CityListViewControllerTestSuite: XCTestCase {
    
    var cityListViewController: CityListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.cityListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityListViewControllerID") as? CityListViewController
        _ = cityListViewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReorderGroupsVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(self.cityListViewController.tableView)
    }
    
    func testViewDidLoad_SetsTableViewDataSource(){
        XCTAssertNotNil(self.cityListViewController.tableView.dataSource)
    }

    func testViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(self.cityListViewController.tableView.delegate)
    }
    
    func testViewNumberOfSections() {
        XCTAssertEqual(self.cityListViewController.tableView.numberOfSections, 1)
    }
    
    func testViewNumberOfRows() {
        XCTAssertEqual(self.cityListViewController.tableView.numberOfRows(inSection: 0), 6)
    }
}
