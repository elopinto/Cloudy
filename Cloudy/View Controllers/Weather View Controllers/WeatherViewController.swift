//
//  WeatherViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeatherViewController {
    func imageForIcon(withName name: String) -> UIImage?
}

extension WeatherViewController {
    func imageForIcon(withName name: String) -> UIImage {
        let image: UIImage

        switch name {
        case "clear-day", "clear-night", "rain", "snow", "sleet":
            image = UIImage(imageLiteralResourceName: name)
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            image = UIImage(imageLiteralResourceName: "cloudy")
        default:
            image = UIImage(imageLiteralResourceName: "clear-day")
        }

        return image
    }
}
