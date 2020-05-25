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
    var buttonFahrenheit =  UIButton()
    var buttonCelsius =  UIButton()
    
    //MARK: - View Life Cycle
    
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
        addFooterView()
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
    
    //MARK: - Class Private Functions
    
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
    
    /// Set footer view on table view
    ///
    /// Use this method to set Celsius and Far button on table view footer
    private func addFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:40)
        buttonCelsius.frame = CGRect(x: 20, y: 5, width: 30, height: 30)
        buttonCelsius.setTitle("C", for: .normal)
        buttonCelsius.addTarget(self, action: #selector(self.setCelsiusButtonTapped), for: .touchUpInside)
        buttonCelsius.setTitleColor(UIColor.black, for: .selected)
        buttonCelsius.backgroundColor = UIColor.clear
        let sepratorLabel = UILabel()
        sepratorLabel.frame = CGRect(x: 50, y: 0, width: 5, height: 40)
        sepratorLabel.text = "/"
        sepratorLabel.textColor = UIColor.white
        footerView.addSubview(sepratorLabel)
        buttonFahrenheit.frame = CGRect(x: 55, y: 5, width: 30, height: 30)
        buttonFahrenheit.setTitle("F", for: .normal)
        buttonFahrenheit.setTitleColor(UIColor.black, for: .selected)
        buttonFahrenheit.addTarget(self, action: #selector(self.setFahrenheitButtonTapped), for: .touchUpInside)
        buttonFahrenheit.backgroundColor = UIColor.clear
        if(UserDefaultHelper.getTempratureUnit() == "C") {
            buttonCelsius.isSelected = true
        } else {
            buttonFahrenheit.isSelected = true
        }
        footerView.addSubview(buttonCelsius)
        footerView.addSubview(buttonFahrenheit)
        self.tableView.tableFooterView = footerView
    }
    
    /// setCelsiusButtonTapped methos will be called as user tap on C button on screen
    ///
    /// Use this method to set temp unit in user default
    @objc private func setCelsiusButtonTapped()
    {
        buttonCelsius.isSelected = true
        buttonFahrenheit.isSelected = false
        UserDefaultHelper.setTempratureUnit(unit: "C")
        self.tableView.reloadData()
    }
    
    /// setFahrenheitButtonTapped methos will be called as user tap on F button on screen
    ///
    /// Use this method to set temp unit in user default
    @objc private func setFahrenheitButtonTapped()
    {
        buttonCelsius.isSelected = false
        buttonFahrenheit.isSelected = true
        UserDefaultHelper.setTempratureUnit(unit: "F")
        self.tableView.reloadData()
    }
    
    //MARK: - Table view deligate and data source methods
    
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
        if(indexPath.row != 1 && indexPath.row != 2 && indexPath.row != 0) {
            return true
        } else {
            return false
        }
        
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
