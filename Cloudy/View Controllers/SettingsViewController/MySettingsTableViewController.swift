//
//  MySettingsTableViewController.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/15/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol MySettingsViewControllerDelegate {
    func controllerDidChangeTimeNotation(controller: MySettingsTableViewController)
    func controllerDidChangeUnitsNotation(controller: MySettingsTableViewController)
    func controllerDidChangeTemperatureNotation(controller: MySettingsTableViewController)
}

class MySettingsTableViewController: UITableViewController {

    var delegate: MySettingsViewControllerDelegate?

    // MARK: - Properties

    var timeNotation: TimeNotation {
        get {
            return UserDefaults.timeNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.timeNotation)
            delegate?.controllerDidChangeTimeNotation(controller: self)
        }
    }

    var unitsNotation: UnitsNotation {
        get {
            return UserDefaults.unitsNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.unitsNotation)
            delegate?.controllerDidChangeUnitsNotation(controller: self)
        }
    }

    var temperatureNotation: TemperatureNotation {
        get {
            return UserDefaults.temperatureNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.temperatureNotation)
            delegate?.controllerDidChangeTemperatureNotation(controller: self)
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        func addCheckmarkToCell<T: RawRepresentable>(for notation: T) where T.RawValue==Int {
            if indexPath.row == notation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }

        if indexPath.section == 0 {
            addCheckmarkToCell(for: timeNotation)
        } else if indexPath.section == 1 {
            addCheckmarkToCell(for: unitsNotation)
        } else if indexPath.section == 2 {
            addCheckmarkToCell(for: temperatureNotation)
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        func manageSelection<T: RawRepresentable>(for notation: inout T) where T.RawValue==Int {
            guard let newNotation = T(rawValue: indexPath.row) else {
                return
            }

            let previousSelectedIndexPath = IndexPath(row: notation.rawValue, section: indexPath.section)
            let previousCell = tableView.cellForRow(at: previousSelectedIndexPath)
            previousCell?.accessoryType = .none

            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            notation = newNotation
        }

        if indexPath.section == 0 {
            manageSelection(for: &timeNotation)
        } else if indexPath.section == 1 {
            manageSelection(for: &unitsNotation)
        } else if indexPath.section == 2 {
            manageSelection(for: &temperatureNotation)
        }
    }

}
