//
//  UserDefaults.swift
//  Cloudy
//
//  Created by Bart Jacobs on 03/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import Foundation

protocol Notation: RawRepresentable {
    static var userDefaultKey: String { get }
}

extension Notation where Self.RawValue==Int {

    static func getNotation() -> Self {
        let storedValue = UserDefaults.standard.integer(forKey: Self.userDefaultKey)
        return Self(rawValue: storedValue) ?? Self(rawValue: 0)!
    }

    func setNotation() {
        UserDefaults.standard.set(self.rawValue, forKey: Self.userDefaultKey)
    }

}

enum TimeNotation: Int, Notation {
    case twelveHour
    case twentyFourHour

    static var userDefaultKey: String {
        return "timeNotation"
    }
}

enum UnitsNotation: Int, Notation {
    case imperial
    case metric

    static var userDefaultKey: String {
        return "unitsNotation"
    }
}

enum TemperatureNotation: Int, Notation {
    case fahrenheit
    case celsius

    static var userDefaultKey: String {
        return "temperatureNotation"
    }
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

    static func getNotation<T: Notation>(for key: String) -> T where T.RawValue==Int {
        let storedValue = UserDefaults.standard.integer(forKey: key)
        return T(rawValue: storedValue) ?? T(rawValue: 0)!
    }

    static func setNotation<T: Notation>(_ notation: T, for key: String) where T.RawValue==Int {
        UserDefaults.standard.set(notation.rawValue, forKey: key)
    }

}
