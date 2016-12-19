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
