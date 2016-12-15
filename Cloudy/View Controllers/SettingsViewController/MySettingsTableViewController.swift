//
//  MySettingsTableViewController.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/15/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

class MySettingsTableViewController: UITableViewController {

    var timeNotation: TimeNotation {
        get {
            return UserDefaults.timeNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.timeNotation)
        }
    }

    var unitsNotation: UnitsNotation {
        get {
            return UserDefaults.unitsNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.unitsNotation)
        }
    }

    var temperatureNotation: TemperatureNotation {
        get {
            return UserDefaults.temperatureNotation()
        }
        set {
            UserDefaults.setNotation(newValue, for: UserDefaultsKeys.temperatureNotation)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func addCheckmark<T: RawRepresentable>(to cell: UITableViewCell,
        at indexPath: IndexPath,
        for notation: T) where T.RawValue==Int
    {
        if indexPath.row == notation.rawValue {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if indexPath.section == 0 {
            addCheckmark(to: cell, at: indexPath, for: timeNotation)
        } else if indexPath.section == 1 {
            addCheckmark(to: cell, at: indexPath, for: unitsNotation)
        } else if indexPath.section == 2 {
            addCheckmark(to: cell, at: indexPath, for: temperatureNotation)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIndexPath = IndexPath(row: <#T##Int#>, section: <#T##Int#>)
    }

}
