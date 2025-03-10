//
//  SLMapViewViewModel.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 8.03.2025.
//

import Foundation
import CoreLocation

protocol SLMapViewViewModelDelegate: AnyObject {
    func didUpdateMap(with coordinate: CLLocationCoordinate2D)
    func didFailWithError(_ error: Error)
    func didResetMap()
}

final class SLMapViewViewModel {
    weak var delegate: SLMapViewViewModelDelegate?
    private var locationManager: LocationManager
    private var lastRecordedLocation: CLLocation?
    private(set) var isTracking: Bool = false

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
    }
    
    func toggleTracking() {
        isTracking.toggle()
        if isTracking {
            locationManager.startTracking()
        } else {
            locationManager.stopTracking()
        }
    }

    func resetTracking() {
        lastRecordedLocation = nil
        locationManager.stopTracking()
        delegate?.didResetMap()
    }
}

extension SLMapViewViewModel: LocationManagerDelegate {
    func didUpdateLocation(_ locations: [CLLocation]) {
        guard isTracking, let newLocation = locations.last else { return }
        
        if let lastLocation = lastRecordedLocation {
            let distance = newLocation.distance(from: lastLocation)
            if distance < 100 { return }
        }
        lastRecordedLocation = newLocation
        delegate?.didUpdateMap(with: newLocation.coordinate)
    }

    func didFailWithError(_ error: Error) {
        delegate?.didFailWithError(error)
    }
}
