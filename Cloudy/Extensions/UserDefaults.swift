//
//  UserDefaults.swift
//  Cloudy
//
//  Created by Bart Jacobs on 03/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import Foundation

enum TimeNotation: Int {
    case twelveHour
    case twentyFourHour
}

enum UnitsNotation: Int {
    case imperial
    case metric
}

enum TemperatureNotation: Int {
    case fahrenheit
    case celsius
}

struct UserDefaultsKeys {
    static let timeNotation = "timeNotation"
    static let unitsNotation = "unitsNotation"
    static let temperatureNotation = "temperatureNotation"
}

extension UserDefaults {

    // MARK: - Timer Notation

    static func timeNotation() -> TimeNotation {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaultsKeys.timeNotation)
        return TimeNotation(rawValue: storedValue) ?? TimeNotation.twelveHour
    }

    // MARK: - Units Notation
    
    static func unitsNotation() -> UnitsNotation {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaultsKeys.unitsNotation)
        return UnitsNotation(rawValue: storedValue) ?? UnitsNotation.imperial
    }

    // MARK: - Temperature Notation
    
    static func temperatureNotation() -> TemperatureNotation {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaultsKeys.temperatureNotation)
        return TemperatureNotation(rawValue: storedValue) ?? TemperatureNotation.fahrenheit
    }

    static func setNotation<T: RawRepresentable>(_ notation: T, for key: String) where T.RawValue==Int {
        UserDefaults.standard.set(notation.rawValue, forKey: key)
    }

}
