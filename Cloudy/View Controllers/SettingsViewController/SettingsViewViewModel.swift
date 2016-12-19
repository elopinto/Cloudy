//
//  SettingsViewViewModel.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/17/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

struct SettingsViewViewModel<Setting: Notation> where Setting.RawValue==Int {

    var setting: Setting

    var accessoryType: UITableViewCellAccessoryType {
        return Setting.getNotation() == setting ? .checkmark : .none
    }

}
