//
//  WeatherListViewController.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController {
    
    var weatherDataModel = WeatherDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getWeatherDataFromViewModel()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        self.title = "Weather"
    }
    
    /// Fetch weather data from view model class
    ///
    /// Use this method to get data from ViewModel class and manage its response status
    func getWeatherDataFromViewModel() {
        self.addActivityIndicator()
        weatherDataModel.getWeatherForCitiesList {result in
            self.stopActivityIndicator()
            switch(result) {
            case .success:
                print("Sucess")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if (segue.identifier == "WeatherDetail"){
            let destinationVC = segue.destination as! WeatherDetailTableViewController
            destinationVC.selectedCellIndex = self.tableView.indexPathForSelectedRow?.row
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.weatherListCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.weatherCustomCellIdentifier) as! WeatherTableViewCell
        cell.tag = indexPath.row
        cell.setWeatherCellWithData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String(indexPath.row))
//        let viewController = WeatherDetailTableViewController()
//        viewController.selectedCellIndex = indexPath.row
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete, remove city name from weatehr list
            
        }
    }
}
