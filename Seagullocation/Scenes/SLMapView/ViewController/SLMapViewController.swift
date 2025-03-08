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
    private let locationManager: LocationManager!
    
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
    
    func setuplocationManager() {
        locationManager.delegate = self
        locationManager.requestLocation()
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
    
    @IBAction func resetLocationButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        
    }
}
