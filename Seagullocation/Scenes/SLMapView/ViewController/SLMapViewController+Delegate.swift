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
    func didUpdateLocation(_ locations: [CLLocation]) {
        guard let newLocation = locations.last,
              let lastLocation = locationManager.lastRecordedLocation
        else { return }
        
        let distance = newLocation.distance(from: lastLocation)
        if distance < 1 { return }
        locationManager.lastRecordedLocation = newLocation
        
        DispatchQueue.main.async {
            self.addMarker(at: newLocation.coordinate)
            self.updateTrail(with: newLocation.coordinate)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Location error: \(error.localizedDescription)") // TODO: Make Alert
    }
}

extension SLMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer()
    }
}
