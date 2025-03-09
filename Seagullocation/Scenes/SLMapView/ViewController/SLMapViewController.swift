//
//  SLMapViewController.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 7.03.2025.
//

import UIKit
import MapKit

final class SLMapViewController: UIViewController {

    @IBOutlet private(set) weak var mapView: MKMapView!
    @IBOutlet private weak var resetLocationButton: UIButton!
    @IBOutlet private weak var startStopButton: UIButton!
    private(set) var locationManager: LocationManager!
    
    private var locations: [CLLocationCoordinate2D] = []
    private var polyline: MKPolyline?
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuplocationManager()
        setupMapView()
        configureResetLocationButton()
        configureStartStopButton()
        
    }
    
    private func setuplocationManager() {
        locationManager.delegate = self
    }
    
    private func setupMapView() {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureResetLocationButton() {
        resetLocationButton.titleLabel?.text = String(localized: "MapView.ResetButton.Title")
        resetLocationButton.layer.cornerRadius = 8
    }
    
    private func configureStartStopButton() {
        startStopButton.titleLabel?.text = String(localized: "MapView.StartButton.Title")
        startStopButton.layer.cornerRadius = 8
        startStopButton.addShadow(shadowProperties: ButtonShadowProperties())
    }
    
    func addMarker(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    func updateTrail(with coordinate: CLLocationCoordinate2D) {
        locations.append(coordinate)
        
        if let polyline = polyline {
            mapView.removeOverlay(polyline)
        }
        
        polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline!)
    }
    
    @IBAction func resetLocationButtonTapped(_ sender: Any) {
        locations.removeAll()
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        locationManager.startTracking()
    }
}
