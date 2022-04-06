//
//  AddNewCityManager.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 05.04.2022.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    func addNewCity(name: String, placeholder: String, completion: @escaping(String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            
            let textField = alert.textFields?.first
            textField?.delegate = self
            
            guard let cityName = textField!.text else { return }
            
            completion(cityName)
        }
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.becomeFirstResponder()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
