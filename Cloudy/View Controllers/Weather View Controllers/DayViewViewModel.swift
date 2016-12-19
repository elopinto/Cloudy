//
//  DayViewViewModel.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/19/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

struct DayViewViewModel {

    let weatherData: WeatherData

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        return dateFormatter
    }()

    private let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TimeNotation.getNotation() == .twelveHour ? "hh:mm a" : "HH:mm"
        return dateFormatter
    }()

    var date: String {
        return dateFormatter.string(from: weatherData.time)
    }

    var time: String {
        return timeFormatter.string(from: weatherData.time)
    }

    var windSpeed: String {
        let string: String

        switch UnitsNotation.getNotation() {
        case .imperial:
            string = String(format: "%.f MPH", weatherData.windSpeed)
        case .metric:
            string = String(format: "%.f KPH", weatherData.windSpeed.toKPH())
        }

        return string
    }

    var temperature: String {
        let string: String

        switch TemperatureNotation.getNotation() {
        case .fahrenheit:
            string = String(format: "%.1f °F", weatherData.temperature)
        case .celsius:
            string = String(format: "%.1f °C", weatherData.temperature.toCelcius())
        }

        return string
    }

    var description: String {
        return weatherData.summary
    }

    var image: UIImage {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }
    
}
