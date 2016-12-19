//
//  DayViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol DayViewControllerDelegate {
    func controllerDidTapSettingsButton(controller: DayViewController)
}

class DayViewController: UIViewController, WeatherViewController {

    // MARK: - Properties

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: -

    var delegate: DayViewControllerDelegate?

    // MARK: -

    var now: WeatherData? {
        didSet {
            updateView()
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Interface

    func reloadData() {
        updateView()
    }

    // MARK: - View Methods

    private func updateView() {
        if let now = now {
            updateWeatherDataContainer(withWeatherData: now)
        }
    }

    // MARK: -

    private func updateWeatherDataContainer(withWeatherData weatherData: WeatherData) {
        var windSpeed = weatherData.windSpeed
        var temperature = weatherData.temperature

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        dateLabel.text = dateFormatter.string(from: weatherData.time)

        let timeFormatter = DateFormatter()

        if TimeNotation.getNotation() == .twelveHour {
            timeFormatter.dateFormat = "hh:mm a"
        } else {
            timeFormatter.dateFormat = "HH:mm"
        }

        timeLabel.text = timeFormatter.string(from: weatherData.time)

        descriptionLabel.text = weatherData.summary

        if TemperatureNotation.getNotation() != .fahrenheit {
            temperature = temperature.toCelcius()
            temperatureLabel.text = String(format: "%.1f °C", temperature)
        } else {
            temperatureLabel.text = String(format: "%.1f °F", temperature)
        }

        if UnitsNotation.getNotation() != .imperial {
            windSpeed = windSpeed.toKPH()
            windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
        } else {
            windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
        }

        iconImageView.image = imageForIcon(withName: weatherData.icon)
    }

    // MARK: - Actions

    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

}
