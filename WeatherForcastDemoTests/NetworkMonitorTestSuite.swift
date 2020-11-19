//
//  NetworkMonitorTestSuite.swift
//  WeatherForcastDemoTests
//
//  Created by Usman Ansari on 19/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherForcastDemo
class NetworkMonitorTestSuite: XCTestCase{
    var expectation : XCTestExpectation?
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testMonitoring() {
        self.expectation = XCTestExpectation(description: "Delegate method should fire")
        NetworkMonitor.shared.startMonitoring()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.networkRechabliltyChanged(_:)),
            name: NSNotification.Name(rawValue: Constants.Network.NetworkReachabilityChanged),
            object: nil)
        self.wait(for: [self.expectation!], timeout: 0.1)
    }
        
    // MARK:
    // MARK: Notification Methods -

    /**
     This method is is called when reachability changed.
     - parameter notification: instance of NSNotification
     */
    @objc func networkRechabliltyChanged(_ notification: Notification) {
        self.expectation?.fulfill()
    }
}
