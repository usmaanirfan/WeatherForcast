//
//  CityDetail.swift
//  WeatherForecast
//
//  Created by Usman Ansari on 17/11/20.
//

import Foundation

struct LocationDetail: Decodable {
    var title: String
    var locationType: String
    var woeid: Int
    var lattLong: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case locationType = "location_type"
        case woeid = "woeid"
        case lattLong = "latt_long"
    }
}

