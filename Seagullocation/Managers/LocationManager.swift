//
//  LocationManager.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 8.03.2025.
//

import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ locations: [CLLocation])
    func didFailWithError(_ error: Error)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    var lastRecordedLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func startTracking() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Location access denied.")
        }
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
            locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Permission denied. Show an alert to guide the user.") // TODO: Make alert
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.didUpdateLocation(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
    }
}
