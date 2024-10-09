//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import Foundation
import DomainLayer

public protocol FlightDetailViewModelProtocol {
    var flight: Flight { get set }
}

public protocol FlightDetailViewModelDelegate {
    func close()
}

class FlightDetailViewModel: FlightDetailViewModelProtocol {
    var flight: Flight
    
    weak var coordinator: (Coordinator & FlightDetailViewModelDelegate)?
    
    init(flight: Flight, coordinator: (Coordinator & FlightDetailViewModelDelegate)) {
        self.flight = flight
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.close()
    }
}
