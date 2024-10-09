//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation
import DomainLayer

public protocol FlightsHistoryViewModelProtocol {
    var flights: [Flight] { get set }
    var status: Status { get set }
    var statusItems: [Status] { get set }
    var error: String? { get set }
    
    func changeFlightStatus(status: Status)
    func list(completion: @escaping () -> Void)
    func didSelect(flight: Flight)
}

public protocol FlightsHistoryViewModelDelegate {
    func didSelect(flight: Flight)
}

class FlightsHistoryViewModel: FlightsHistoryViewModelProtocol {
    let useCase: ListFlightsUseCaseProtocol
    
    var status: Status = .all
    var statusItems: [Status] = Status.allCases
    
    var flights: [Flight] = []
    var error: String?
    
    weak var coordinator: (Coordinator & FlightsHistoryViewModelDelegate)?
    
    init(useCase: ListFlightsUseCaseProtocol, coordinator: (Coordinator & FlightsHistoryViewModelDelegate)) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func list(completion: @escaping () -> Void) {
        self.useCase.execute(
            status: status
        ) { [weak self] flights, error in
            if let error {
                self?.error = error
            }
            
            if let flights {
                self?.flights = flights
            }
            completion()
        }
    }
    
    func changeFlightStatus(status: Status) {
        self.status = status
    }
    
    func didSelect(flight: Flight) {
        coordinator?.didSelect(flight: flight)
    }
}
