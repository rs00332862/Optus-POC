//
//  WeatherDetailTableViewController.swift
//  Optus POC
//
//  Created by Rohit on 5/23/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherDetailTableViewController: UITableViewController {
    
    let weeklyWeatherViewModel = WeeklyWeatherViewModel()
    var selectedCellIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = WeatherDataViewModel.getCityNameFor(indexPathRow: selectedCellIndex!)
        getWeatherDataForCity()
    }
    
    
    func getWeatherDataForCity() {
        weeklyWeatherViewModel.getWeeklyWeatherForCity(selectedCellIndex: selectedCellIndex!){response in
            switch(response) {
            case .success:
                DispatchQueue.main.async {
                    let indexPathRow:Int = 1
                    let indexPosition = IndexPath(row: indexPathRow, section: 0)
                    self.tableView.reloadRows(at: [indexPosition], with: .none)
                }
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customWeatherCell", for: indexPath) as! WeatherDetailTableViewCell
            if (selectedCellIndex != nil) {
                cell.setWeatherDetailCellFor(indexPathRow: selectedCellIndex ?? 0)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyWeatherCellIdentifier", for: indexPath) as! WeeklyWeatherTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 268
        } else {
            return 194
        }
    }
}
