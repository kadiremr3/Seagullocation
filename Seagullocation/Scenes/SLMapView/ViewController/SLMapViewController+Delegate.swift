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
    func didUpdateMap(with coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.addMarker(at: coordinate)
            self.updateTrail(with: coordinate)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Location error: \(error.localizedDescription)") // TODO: Show alert
    }
    
    func didUpdateTrackingState(isTracking: Bool) {
        let title = isTracking ? String(localized: "MapView.StopButton.Title") : String(localized: "MapView.StartButton.Title")
        startStopButton.setTitle(title, for: .normal)
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
