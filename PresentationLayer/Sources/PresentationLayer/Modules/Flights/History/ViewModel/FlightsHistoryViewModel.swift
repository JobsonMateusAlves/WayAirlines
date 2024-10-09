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
    var error: String? { get set }
    
    func list(status: FlightStatus, completion: @escaping () -> Void)
}

class FlightsHistoryViewModel: FlightsHistoryViewModelProtocol {
    let useCase: ListFlightsUseCaseProtocol
    
    var flightStatus: FlightStatus = .all
    
    var flights: [Flight] = []
    var error: String?
    
    init(useCase: ListFlightsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func list(status: FlightStatus, completion: @escaping () -> Void) {
        self.flightStatus = status
        self.useCase.execute(
            status: flightStatus
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
}
