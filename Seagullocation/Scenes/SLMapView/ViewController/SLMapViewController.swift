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
    @IBOutlet private(set) weak var startStopButton: UIButton!
    
    private(set) var viewModel: SLMapViewViewModel!
    private var polyline: MKPolyline?
    var locations: [CLLocationCoordinate2D] = []
    
    init(viewModel: SLMapViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupMapView()
        configureResetLocationButton()
        configureStartStopButton()
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureResetLocationButton() {
        resetLocationButton.setTitle(String(localized: "MapView.ResetButton.Title"), for: .normal)
        resetLocationButton.layer.cornerRadius = 8
    }
    
    private func configureStartStopButton() {
        startStopButton.setTitle(String(localized: "MapView.StartButton.Title"), for: .normal)
        startStopButton.layer.cornerRadius = 8
        startStopButton.addShadow(shadowProperties: ButtonShadowProperties())
    }
    
    func addMarker(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func shareLocation(
        latitude: Double,
        longitude: Double
    ) {
        let locationURL = "https://maps.apple.com/?ll=\(latitude),\(longitude)"
        let activityVC = UIActivityViewController(
            activityItems: [locationURL],
            applicationActivities: nil
        )
        present(activityVC, animated: true)
    }
    
    func updateTrail(with coordinate: CLLocationCoordinate2D) {
        locations.append(coordinate)
        
        if let polyline = polyline {
            mapView.removeOverlay(polyline)
        }
        polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline!)
    }
    
    private func updateButtonAppereance() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            let title = self.viewModel.isTracking ?
            String(localized: "MapView.StopButton.Title") :
            String(localized: "MapView.StartButton.Title")
            self.startStopButton.setTitle(title, for: .normal)
            self.startStopButton.backgroundColor = self.viewModel.isTracking ? .red : .systemGreen
        }
    }
    
    @IBAction func resetLocationButtonTapped(_ sender: Any) {
        viewModel.resetTracking()
        updateButtonAppereance()
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        viewModel.toggleTracking()
        updateButtonAppereance()
    }
}
