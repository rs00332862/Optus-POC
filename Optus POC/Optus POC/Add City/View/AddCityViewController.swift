//
//  AddCityViewController.swift
//  Optus POC
//
//  Created by Rohit on 5/24/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class AddCityViewController: UITableViewController {
    
    let cityViewModel = CityViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("AddCityScreenTitleText", comment: "")
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        self.addActivityIndicator()
        setUpSearchViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCityData()
    }
    
    func fetchCityData() {
        cityViewModel.readCityDataFromJSON { response in
            self.stopActivityIndicator()
            switch(response) {
            case .success:
                print("Success")
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }
    
    /// Method to setup search view controller on view controller
    func setUpSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("SearchTextFieldPlaceHolderText", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        } else {
            searchController.searchBar.placeholder = NSLocalizedString("SearchTextFieldPlaceHolderText", comment: "")
        }  //
        
        
        searchController.searchBar.barTintColor = UIColor.init(red: 35.0/255, green: 163.0/255, blue: 229.0/255, alpha: 1)
        
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.filteredCityList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //saveSeclectedCityObject
        let lastCityObject = cityViewModel.filteredCityList[indexPath.row]
        UserDefaultHelper.saveSeclectedCityObject(cityData: lastCityObject){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        let lastCityObject = cityViewModel.filteredCityList[indexPath.row]
        cell.cityNameLabel.text = lastCityObject.cityName
        return cell
    }
}

//MARK: - UISearchBar Delegate
extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        cityViewModel.filterEmployeeDataWith(string: searchBar.text!) {
            self.tableView.reloadData()
        }
    }
}
