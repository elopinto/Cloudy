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

class WeekViewController: UITableViewController {

    // MARK: -

    var delegate: WeekViewControllerDelegate?
    
    // MARK: -

    var week: WeekTableViewViewModel? {
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

    // MARK: - Public Interface

    func reloadData() {
        updateView()
    }
    
    // MARK: - View Methods

    private func updateView() {
        tableView.refreshControl?.endRefreshing()

        if week != nil {
            updateWeatherDataContainer()
        }
    }

    // MARK: - Actions

    @IBAction func didRefresh(_ sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(controller: self)
    }

    // MARK: -

    private func updateWeatherDataContainer() {
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return week?.numberOfSections ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return week?.numberOfCells ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherDayTableViewCell.reuseIdentifier,
            for: indexPath) as? WeatherDayTableViewCell else {
            fatalError("Unexpected Table View Cell")
        }

        if let dayViewModel = week?.viewModelForItem(at: indexPath.row) {
            cell.dayLabel.text = dayViewModel.day
            cell.dateLabel.text = dayViewModel.date
            cell.temperatureLabel.text = dayViewModel.temperature
            cell.windSpeedLabel.text = dayViewModel.windSpeed
            cell.iconImageView.image = dayViewModel.image
        }

        return cell
    }

}
