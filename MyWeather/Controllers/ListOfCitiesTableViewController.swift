//
//  ListOfCitiesTableViewController.swift
//  MyWeather
//
//  Created by Наталья Шарапова on 31.03.2022.
//

import UIKit
import CoreLocation

class ListOfCitiesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    var filterCityArray = [Weather]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var nameCityArray = ["Vladikavkaz", "Barnaul" , "Petersburg", "Mineralnye vody", "Kemerovo", "Pyatigorsk", "Astrakhan", "Khanty-Mansiysk", "Krasnodar", "Sochi"]
    
    
    // MARK: - LifeCycle ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCityArray.count)
        }
        
        addCitiesWeatherToTheArray()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Methods
    
    func addCitiesWeatherToTheArray() {
        
        // Filling the citiesArray
        
        getCityWeather(nameCityArray: nameCityArray) { index, weather in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCityArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "goToDetail" else { return }
        
        let destination = segue.destination as! DetailViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if isFiltering {
            
            let filterCity = filterCityArray[indexPath.row]
            destination.weather = filterCity
            
        } else {
            
            let weather = citiesArray[indexPath.row]
            destination.weather = weather
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of cities"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filterCityArray.count
        }
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        
        if isFiltering {
            cell.configure(with: filterCityArray[indexPath.row])
        } else {
            cell.configure(with: citiesArray[indexPath.row])
            
        }
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        addNewCity(name: "City", placeholder: "Enter the name of the city") { nameCity in
            self.nameCityArray.append(nameCity)
            self.citiesArray.append(self.emptyCity)
            self.addCitiesWeatherToTheArray()
        }
    }
}

// MARK: - Extensions

extension ListOfCitiesTableViewController /*: UITableViewDelegate */ {
    
    // Add possibility to delete the cell
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch  editingStyle {
        
        case .delete:
            if isFiltering {
                filterCityArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                citiesArray.remove(at: indexPath.row)
                nameCityArray.remove(at: indexPath.row)
            } else {
                citiesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}

extension ListOfCitiesTableViewController: UISearchResultsUpdating {
    
    // Updating search results
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    // Filter search results
    
    private func filterContentForSearchText(searchText: String) {
        
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
