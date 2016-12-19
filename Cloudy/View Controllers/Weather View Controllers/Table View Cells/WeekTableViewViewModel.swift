//
//  WeekTableViewViewModel.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/19/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

struct WeekTableViewViewModel {

    let weekWeatherData: [WeatherDayData]

    var numberOfSections: Int {
        return 1
    }

    var numberOfCells: Int {
        return weekWeatherData.count
    }

    func viewModelForItem(at index: Int) -> WeekTableViewCellViewModel {
        return WeekTableViewCellViewModel(weatherDayData: weekWeatherData[index])
    }

}
