//
//  WeatherListViewController.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var weatherDataModel = WeatherDataViewModel()
    var activityView: UIActivityIndicatorView?
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addActivityIndicator()
        self.getWeatherDataFromViewModel()
        self.title = "Weather"
    }
    
    ///function to add activity indicator on view controller
    private func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    /// Fetch weather data from view model class
    ///
    /// Use this method to get data from ViewModel class and manage its response status
    private func getWeatherDataFromViewModel() {
        self.activityView?.startAnimating()
        weatherDataModel.getWeatherForCitiesList {result in
            self.activityView?.stopAnimating()
            switch(result) {
            case .success:
                print("Sucess")
                self.weatherTableView.reloadData()
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }
    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableView Delegate

extension WeatherListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.weatherListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.weatherCustomCellIdentifier) as! WeatherTableViewCell
        cell.setWeatherCellWith(weatherData: weatherDataModel.weatherListArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete, remove city name from weatehr list
            
        }
    }
    
}
