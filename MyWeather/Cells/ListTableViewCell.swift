//
//  ListTableViewCell.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 03.04.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameOfCityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(with city: Weather) {
        
        nameOfCityLabel.text = city.name
        statusLabel.text = city.condition
        degreesLabel.text = city.temperatureString
    }
}
