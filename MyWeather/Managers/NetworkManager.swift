//
//  NetworkManager.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 31.03.2022.
//

import UIKit

class NetworkManager {
    
    // Singletone init
    
    static let shared = NetworkManager()
    
    let apiKey = "7b54ee7e-1525-4b2f-9d60-69bef77e0c66"
    
    private init(){}
    
    // MARK: - Methods
    
    // Fetch weather with urlsession
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping(Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        request.addValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(#line, #function, error!.localizedDescription)
                return
            }
            
            if let weather = self.parseJSON(with: data) {
                completion(weather)
            }
        }
        
        dataTask.resume()
    }
    
    // Parse the data
    func parseJSON(with data: Data) -> Weather? {
        
        let decoder = JSONDecoder()
        
        do {
            let weatherData = try decoder.decode(WeatherModel.self, from: data)
            guard let weather = Weather(weatherModel: weatherData) else { return nil }
            return weather
        }
        
        catch let error {
            print(#line, error.localizedDescription)
        }
        return nil
    }
}
