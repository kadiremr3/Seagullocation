//
//  SLMapViewViewModel.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 8.03.2025.
//

import Foundation

protocol SLMapViewViewModelDelegate: AnyObject {
    
}

final class SLMapViewViewModel {
    
    weak var delegate: SLMapViewViewModelDelegate?
}
