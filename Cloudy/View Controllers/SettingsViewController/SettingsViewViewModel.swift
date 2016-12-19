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
            setting.setNotation()
            didChangeSetting?(self)
        }
    }

    var didChangeSetting: ((SettingsViewViewModel<Setting>) -> Void)?

    init(didChangeSetting: ((SettingsViewViewModel<Setting>) -> Void)?) {
        self.didChangeSetting = didChangeSetting
    }

    func accessoryType(for index: Int) -> UITableViewCellAccessoryType {
        return setting.rawValue == index ? .checkmark : .none
    }

    mutating func updateSetting(at index: Int) throws {
        guard let newSetting = Setting(rawValue: index) else {
            throw UpdateSettingFailure.invalidRawValue
        }

        self.setting = newSetting
    }

}
