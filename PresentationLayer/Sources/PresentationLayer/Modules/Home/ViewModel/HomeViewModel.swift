//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import Foundation
import DomainLayer

public protocol HomeViewModelProtocol {
    var flight: Flight? { get set }
    
    func getNextFlight(completion: @escaping () -> Void)
}

public protocol HomeViewModelDelegate {
    
}

class HomeViewModel: HomeViewModelProtocol {
    var flight: DomainLayer.Flight?
    
    let useCase: GetNextFlightLeavingUseCaseProtocol
    
    weak var coordinator: (Coordinator & HomeViewModelDelegate)?
    
    init(useCase: GetNextFlightLeavingUseCaseProtocol, coordinator: (Coordinator & HomeViewModelDelegate)) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func getNextFlight(completion: @escaping () -> Void) {
        useCase.execute { flight, error in
            self.flight = flight
            completion()
        }
    }
}
