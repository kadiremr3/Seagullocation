//
//  SLMapViewController+Delegate.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 8.03.2025.
//

import UIKit
import MapKit
import CoreLocation

// MARK: - ViewModelDelegate

extension SLMapViewController: SLMapViewViewModelDelegate {
    
}

// MARK: - LocationManagerDelegate {

extension SLMapViewController: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        DispatchQueue.main.async {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 100,
                longitudinalMeters: 100
            )
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Location error: \(error.localizedDescription)") // TODO: Make Alert
    }
}
