//
//  WeatherDetail.swift
//  WeatherForecast
//
//  Created by Usman Ansari on 17/11/20.
//

import Foundation
struct WeatherDetail: Decodable {
    let consolidatedWeather : [ConsolidatedWeather]
    let parentDetail : ParentDetail
    var title: String
    var locationType: String
    var woeid: Int
    var lattLong: String
    var timezone: String
    
    private enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case parentDetail = "parent"
        case title = "title"
        case locationType = "location_type"
        case woeid = "woeid"
        case lattLong = "latt_long"
        case timezone = "timezone"
    }
}
