//
//  Constants.swift
//  WeatherForecast
//
//  Created by Usman Ansari on 16/11/20.
//

import Foundation
struct Constants {
    struct Endpoint {
        static let baseURL = "https://www.metaweather.com"
        static let cities = ["Gothenburg","Stockholm","Mountain View","London","New York","Berlin"];
    }
    struct CellIdentifiers {
        static let cityCell = "CityCell"
        static let WeatherDetailCell = "WeatherDetailCell"
    }
    struct NavigationConstants {
        static let WeatherDetailIdentifier = "ForecastDetailViewControllerIdentifier"
    }
    struct TableCell {
        static let DetailCellRowHeight = 90.0
    }
    struct Network {
        static let NetworkReachabilityChanged = "NetworkReachabilityChanged"
        static let kReachability = "reachability"
    }
}
