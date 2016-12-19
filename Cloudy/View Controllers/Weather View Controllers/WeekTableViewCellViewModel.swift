//
//  WeekTableViewCellViewModel.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/19/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

struct WeekTableViewCellViewModel {

    let weatherDayData: WeatherDayData

    let dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()

    var day: String {
        return dayFormatter.string(from: weatherDayData.time)
    }

    var date: String {
        return dateFormatter.string(from: weatherDayData.time)
    }

    var temperature: String {
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        return "\(min) - \(max)"
    }

    var windSpeed: String {
        let windSpeed: String

        switch UnitsNotation.getNotation() {
        case .imperial:
            windSpeed = String(format: "%.f MPH", weatherDayData.windSpeed)
        case .metric:
            windSpeed = String(format: "%.f KPH", weatherDayData.windSpeed.toKPH())
        }

        return windSpeed
    }

    var image: UIImage {
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }

    private func format(temperature: Double) -> String {
        let formattedTemperature: String

        switch TemperatureNotation.getNotation() {
        case .fahrenheit:
            formattedTemperature = String(format: "%.0f °F", temperature)
        case .celsius:
            formattedTemperature = String(format: "%.0f °C", temperature.toCelcius())
        }

        return formattedTemperature
    }
}
