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
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getWeatherDataFromViewModel()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        self.title = NSLocalizedString("WeatherListTitleText", comment: "")
        timer = Timer.scheduledTimer(withTimeInterval: 900.0, repeats: true) { timer in
            self.getWeatherDataFromViewModel()
        }
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
        self.title = "Back"
        timer?.invalidate()

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete, remove city name from weatehr list
            let cityID = WeatherDataViewModel.getCityIDFor(indexPathRow: indexPath.row)
            UserDefaultHelper.deleteSelectedCityFromUserDefault(cityID: cityID){
                self.getWeatherDataFromViewModel()
            }
        }
    }
}
