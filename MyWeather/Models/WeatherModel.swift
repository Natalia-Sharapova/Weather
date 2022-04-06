//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 31.03.2022.
//

import Foundation

struct WeatherModel: Decodable {
    
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
}

struct Info: Decodable {
    
    let url: String
}

struct Fact: Decodable {
    let temp: Double
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        
        case temp
        case icon
        case condition
        case pressureMm = "pressure_mm"
        case windSpeed = "wind_speed"
    }
}

struct Forecast: Decodable {
    
    let parts: Parts
}

struct Parts: Decodable {
    
    let day: Day
}

struct Day: Decodable {
    
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}



