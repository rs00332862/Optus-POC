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
        addFooterView()
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
    
    func addFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
        40)
        let buttonCelsius = UIButton()
        buttonCelsius.frame = CGRect(x: 20, y: 5, width: 30, height: 30)
        buttonCelsius.setTitle("C", for: .normal)
        buttonCelsius.addTarget(self, action: #selector(self.setCelsius), for: .touchUpInside)
        buttonCelsius.backgroundColor = UIColor.clear
        buttonCelsius.isSelected = true
        footerView.addSubview(buttonCelsius)
        let sepratorLabel = UILabel()
        sepratorLabel.frame = CGRect(x: 50, y: 0, width: 5, height: 40)
        sepratorLabel.text = "/"
        footerView.addSubview(sepratorLabel)
        let buttonFahrenheit = UIButton()
        buttonFahrenheit.frame = CGRect(x: 55, y: 5, width: 30, height: 30)
        buttonFahrenheit.setTitle("F", for: .normal)
        buttonFahrenheit.addTarget(self, action: #selector(self.setFahrenheit), for: .touchUpInside)
        buttonFahrenheit.backgroundColor = UIColor.clear
        footerView.addSubview(buttonFahrenheit)
        self.tableView.tableFooterView = footerView
    }
    
    @objc private func setCelsius()
    {
        UserDefaultHelper.setTempratureUnit(unit: "C")
        self.tableView.reloadData()
    }
    
    @objc private func setFahrenheit()
    {
        UserDefaultHelper.setTempratureUnit(unit: "F")
        self.tableView.reloadData()
    }
}
