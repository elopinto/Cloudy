//
//  WeekViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate {
    func controllerDidRefresh(controller: WeekViewController)
}

class WeekViewController: UITableViewController, WeatherViewController {

    // MARK: -

    var delegate: WeekViewControllerDelegate?
    
    // MARK: -

    var week: [WeatherDayData]? {
        didSet {
            updateView()
        }
    }

    // MARK: -

    private let dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()

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
        tableView.refreshControl?.endRefreshing()

        if let week = week {
            updateWeatherDataContainer(withWeatherData: week)
        }
    }

    // MARK: - Actions

    @IBAction func didRefresh(_ sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(controller: self)
    }

    // MARK: -

    private func updateWeatherDataContainer(withWeatherData weatherData: [WeatherDayData]) {
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return week == nil ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let week = week else { return 0 }
        return week.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.reuseIdentifier, for: indexPath) as? WeatherDayTableViewCell else { fatalError("Unexpected Table View Cell") }

        if let week = week {
            // Fetch Weather Data
            let weatherData = week[indexPath.row]

            var windSpeed = weatherData.windSpeed
            var temperatureMin = weatherData.temperatureMin
            var temperatureMax = weatherData.temperatureMax

            if UserDefaults.temperatureNotation() != .fahrenheit {
                temperatureMin = temperatureMin.toCelcius()
                temperatureMax = temperatureMax.toCelcius()
            }

            // Configure Cell
            cell.dayLabel.text = dayFormatter.string(from: weatherData.time)
            cell.dateLabel.text = dateFormatter.string(from: weatherData.time)

            let min = String(format: "%.0f°", temperatureMin)
            let max = String(format: "%.0f°", temperatureMax)

            cell.temperatureLabel.text = "\(min) - \(max)"

            if UserDefaults.unitsNotation() != .imperial {
                windSpeed = windSpeed.toKPH()
                cell.windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
            } else {
                cell.windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
            }

            cell.iconImageView.image = imageForIcon(withName: weatherData.icon)
        }

        return cell
    }

}
