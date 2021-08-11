//
//  CityWeatherData.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/11.
//

import Foundation

/*
 {
    "city_name":"베를린",
    "state":12,
    "celsius":10.8,
    "rainfall_probability":60
 },
 */

struct WeatherData: Codable {
    let cityName: String
    let state: Int
    let celsius: Float
    let rainfallProbability: Int
    
    enum CodingKeys: String, CodingKey{
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}
