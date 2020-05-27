//
//  WeeklyWeatherTableViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/23/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeeklyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weeklyWeatherCollectionView: UICollectionView!
    let weeklyWeatherViewModel = WeeklyWeatherViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weeklyWeatherCollectionView.delegate = self
        weeklyWeatherCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

    //MARK: - collection view  data source methods
extension WeeklyWeatherTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyWeatherViewModel.getWeeklyWeatherDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 194)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyWeatherCollectionViewCell", for: indexPath) as! DailyWeatherCollectionViewCell
        cell.tag = indexPath.row
        cell.setDailyWeatherCellData()
        return cell
    }
}
