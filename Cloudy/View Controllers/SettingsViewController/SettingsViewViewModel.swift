//
//  SettingsViewViewModel.swift
//  Cloudy
//
//  Created by Edward LoPinto on 12/17/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

enum UpdateSettingFailure: Error {
    case invalidRawValue
}

struct SettingsViewViewModel<Setting: Notation> where Setting.RawValue==Int {

    var setting: Setting {
        get {
            return Setting.getNotation()
        }
        set {
            newValue.setNotation()
            didChangeSetting?(self)
        }
    }

    var didChangeSetting: ((SettingsViewViewModel<Setting>) -> Void)?

    func accessoryType(for index: Int) -> UITableViewCellAccessoryType {
        return setting.rawValue == index ? .checkmark : .none
    }

    mutating func updateSetting(with rawValue: Int) throws {
        guard let newSetting = Setting(rawValue: rawValue) else {
            throw UpdateSettingFailure.invalidRawValue
        }

        self.setting = newSetting
    }

}
