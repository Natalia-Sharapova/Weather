//
//  DetailViewController.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 04.04.2022.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var imageWeather: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    // MARK: - Properties
    
    var weather: Weather?
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWeather()
    }
    
    // MARK: - Methods
    
    private func setWeather() {
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather!.conditionCode).svg")
        
        let weatherImage = UIView(SVGURL: url!) { image in
            
            image.resizeToFit(self.imageWeather.frame)
        }
        
        imageWeather.addSubview(weatherImage)
        
        nameCityLabel.text = weather?.name
        conditionLabel.text = weather?.condition
        tempLabel.text = weather?.temperatureString
        pressureLabel.text = "\((weather?.pressureMm)!)"
        windLabel.text = "\((weather?.windSpeed)!)"
        minTempLabel.text = "\((weather?.tempMin)!)"
        maxTempLabel.text = "\((weather?.tempMax)!)"
    }
}
