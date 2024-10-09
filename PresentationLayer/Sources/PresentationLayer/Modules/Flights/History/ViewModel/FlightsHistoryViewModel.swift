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
    var flightStatus: FlightStatus { get set }
    var statusItems: [FlightStatus] { get set }
    var error: String? { get set }
    
    func changeFlightStatus(status: FlightStatus)
    func list(completion: @escaping () -> Void)
}

class FlightsHistoryViewModel: FlightsHistoryViewModelProtocol {
    let useCase: ListFlightsUseCaseProtocol
    
    var flightStatus: FlightStatus = .all
    var statusItems: [FlightStatus] = FlightStatus.allCases
    
    var flights: [Flight] = []
    var error: String?
    
    init(useCase: ListFlightsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func list(completion: @escaping () -> Void) {
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
    
    func changeFlightStatus(status: FlightStatus) {
        flightStatus = status
    }
}
