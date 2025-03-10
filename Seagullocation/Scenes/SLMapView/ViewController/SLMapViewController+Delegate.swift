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
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.addMarker(at: coordinate)
            self.updateTrail(with: coordinate)
        }
    }
    
    func didResetMap() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.locations.removeAll()
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Location error: \(error.localizedDescription)") // TODO: Show alert
    }
}

extension SLMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        let latitude = annotation.coordinate.latitude
        let longitude = annotation.coordinate.longitude
        let locationText = String(localized: "General.Location") + ": " + "\(latitude), \(longitude)"
        
        let alertController = UIAlertController(
            title: String(localized: "MapView.Marker.LocationInfo"),
            message: locationText, preferredStyle: .actionSheet
        )
        let shareAction = UIAlertAction(
            title: String(localized: "General.Share"),
            style: .default
        ) { _ in
            self.shareLocation(latitude: latitude, longitude: longitude)
        }
        let closeAction = UIAlertAction(title: String(localized: "General.Close"), style: .cancel, handler: nil)
        alertController.addAction(shareAction)
        alertController.addAction(closeAction)
        present(alertController, animated: true)
    }
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
