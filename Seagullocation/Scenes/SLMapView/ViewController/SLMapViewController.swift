//
//  SLMapViewController.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 7.03.2025.
//

import UIKit
import MapKit

final class SLMapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var resetLocationButton: UIButton!
    @IBOutlet private weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureResetLocationButton()
        configureStartStopButton()
        
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
