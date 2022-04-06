//
//  GetCityWeather.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 02.04.2022.
//

import Foundation
import CoreLocation

func getCityWeather(nameCityArray: [String], completion: @escaping(Int, Weather) -> Void) {
    
    for (index, item) in nameCityArray.enumerated() {
        
        getCoordinateFrom(city: item) { coordinate, error in
            
            guard let coordinate = coordinate, error == nil else { return }
            
            NetworkManager.shared.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completion(index, weather)
            }
        }
    }
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        
        completion(placemark?.first?.location?.coordinate, error)
    }
}
