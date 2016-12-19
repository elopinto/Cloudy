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

    lazy var timeViewModel: SettingsViewViewModel<TimeNotation> = {
        return SettingsViewViewModel<TimeNotation>(didChangeSetting: { (viewModel) in
            self.delegate?.controllerDidChangeNotation(controller: self)
        })
    }()

    lazy var unitsViewModel: SettingsViewViewModel<UnitsNotation> = {
        return SettingsViewViewModel<UnitsNotation>(didChangeSetting: { (viewModel) in
            self.delegate?.controllerDidChangeNotation(controller: self)
        })
    }()

    lazy var temperatureViewModel: SettingsViewViewModel<TemperatureNotation> = {
        return SettingsViewViewModel<TemperatureNotation>(didChangeSetting: { (viewModel) in
            self.delegate?.controllerDidChangeNotation(controller: self)
        })
    }()

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

        func updateCell<T: Notation>(with viewModel: inout SettingsViewViewModel<T>) where T.RawValue==Int {
            let previousIndexPath = IndexPath(row: viewModel.setting.rawValue, section: indexPath.section)

            do {
                try viewModel.updateSetting(at: indexPath.row)
                let previousCell = tableView.cellForRow(at: previousIndexPath)
                previousCell?.accessoryType = viewModel.accessoryType(for: previousIndexPath.row)

                let newCell = tableView.cellForRow(at: indexPath)
                newCell?.accessoryType = viewModel.accessoryType(for: indexPath.row)
            } catch {
                print(error.localizedDescription)
            }
        }

        if indexPath.section == 0 {
            updateCell(with: &timeViewModel)
        } else if indexPath.section == 1 {
            updateCell(with: &unitsViewModel)
        } else if indexPath.section == 2 {
            updateCell(with: &temperatureViewModel)
        }
    }

}
