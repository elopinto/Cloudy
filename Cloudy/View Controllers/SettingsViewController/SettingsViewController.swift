//
//  SettingsTableViewController.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/15/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func controllerDidChangeNotation(controller: SettingsViewController)
}

class SettingsViewController: UITableViewController {

    var delegate: SettingsViewControllerDelegate?

    // MARK: - Properties

    var timeViewModel = SettingsViewViewModel<TimeNotation>()
    var unitsViewModel = SettingsViewViewModel<UnitsNotation>()
    var temperatureViewModel = SettingsViewViewModel<TemperatureNotation>()

    override func viewDidLoad() {
        super.viewDidLoad()

        func didChangeSetting<T: Notation>() -> ((SettingsViewViewModel<T>) -> Void) where T.RawValue==Int {
            return { [unowned self] (viewModel) in
                self.delegate?.controllerDidChangeNotation(controller: self)
            }
        }

        timeViewModel.didChangeSetting = didChangeSetting()
        unitsViewModel.didChangeSetting = didChangeSetting()
        temperatureViewModel.didChangeSetting = didChangeSetting()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if indexPath.section == 0 {
            cell.accessoryType = timeViewModel.accessoryType(for: indexPath.row)
        } else if indexPath.section == 1 {
            cell.accessoryType = unitsViewModel.accessoryType(for: indexPath.row)
        } else if indexPath.section == 2 {
            cell.accessoryType = temperatureViewModel.accessoryType(for: indexPath.row)
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        func updateCells<T: Notation>(with viewModel: inout SettingsViewViewModel<T>) where T.RawValue==Int {
            let previousIndexPath = IndexPath(row: viewModel.setting.rawValue, section: indexPath.section)

            do {
                try viewModel.updateSetting(with: indexPath.row)
                let previousCell = tableView.cellForRow(at: previousIndexPath)
                previousCell?.accessoryType = viewModel.accessoryType(for: previousIndexPath.row)

                let newCell = tableView.cellForRow(at: indexPath)
                newCell?.accessoryType = viewModel.accessoryType(for: indexPath.row)
            } catch {
                print(error.localizedDescription)
            }
        }

        if indexPath.section == 0 {
            updateCells(with: &timeViewModel)
        } else if indexPath.section == 1 {
            updateCells(with: &unitsViewModel)
        } else if indexPath.section == 2 {
            updateCells(with: &temperatureViewModel)
        }
    }

}
