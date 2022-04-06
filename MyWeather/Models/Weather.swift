//
//  Weather.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 31.03.2022.
//

import Foundation

struct Weather {
    
    var name: String = "Loading..."
    var temperature: Double = 0.0
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0.0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    init?(weatherModel: WeatherModel) {
        
        temperature = weatherModel.fact.temp
        conditionCode = weatherModel.fact.icon
        url = weatherModel.info.url
        condition = weatherModel.fact.condition
        pressureMm = weatherModel.fact.pressureMm
        windSpeed = weatherModel.fact.windSpeed
        tempMin = weatherModel.forecasts.first!.parts.day.tempMin!
        tempMax = weatherModel.forecasts.first!.parts.day.tempMax!
    }
    
    init(){}
}
