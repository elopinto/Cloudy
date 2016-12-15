//
//  RootViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController, CLLocationManagerDelegate, DayViewControllerDelegate,
    WeekViewControllerDelegate, SettingsViewControllerDelegate {

    // MARK: - Constants

    private let segueDayView = "SegueDayView"
    private let segueWeekView = "SegueWeekView"
    private let SegueSettingsView = "SegueSettingsView"

    // MARK: - Properties

    @IBOutlet private var dayViewController: DayViewController!
    @IBOutlet private var weekViewController: WeekViewController!

    // MARK: -

    private var currentLocation: CLLocation? {
        didSet {
            fetchWeatherData()
        }
    }

    private lazy var dataManager = {
        return DataManager(baseURL: API.AuthenticatedBaseURL)
    }()

    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()

        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0

        return locationManager
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNotificationHandling()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case segueDayView:
            if let dayViewController = segue.destination as? DayViewController {
                self.dayViewController = dayViewController

                // Configure Day View Controller
                self.dayViewController.delegate = self
                
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        case segueWeekView:
            if let weekViewController = segue.destination as? WeekViewController {
                self.weekViewController = weekViewController

                // Configure Day View Controller
                self.weekViewController.delegate = self

            } else {
                fatalError("Unexpected Destination View Controller")
            }
        case SegueSettingsView:
            if let navigationController = segue.destination as? UINavigationController,
               let settingsViewController = navigationController.topViewController as? SettingsViewController {
                settingsViewController.delegate = self
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        default:
            break
        }
    }

    // MARK: - View Methods

    private func setupView() {

    }

    private func updateView() {

    }

    // MARK: - Actions

    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }

    // MARK: - Notification Handling

    func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }

    // MARK: - Helper Methods

    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(RootViewController.applicationDidBecomeActive(notification:)),
            name: Notification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }

    private func requestLocation() {
        // Configure Location Manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func fetchWeatherData() {
        guard let location = currentLocation else { return }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        print("\(latitude), \(longitude)")

        dataManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                // Configure Day View Controller
                self.dayViewController.now = response

                // Configure Week View Controller
                self.weekViewController.week = response.dailyData
            }
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Request Location
            manager.requestLocation()
        } else {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Update Current Location
            currentLocation = location
        } else {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)

        if currentLocation == nil {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }

    // MARK: - DayViewControllerDelegate

    func controllerDidTapSettingsButton(controller: DayViewController) {
        performSegue(withIdentifier: SegueSettingsView, sender: self)
    }

    // MARK: - WeekViewController Delegate 

    func controllerDidRefresh(controller: WeekViewController) {
        fetchWeatherData()
    }

    // MARK: - SettingsViewControllerDelegate

    func controllerDidChangeTimeNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }

    func controllerDidChangeUnitsNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }

    func controllerDidChangeTemperatureNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }

}
