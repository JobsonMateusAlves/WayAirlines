//
//  File.swift
//  
//
//  Created by Jobson Mateus on 08/10/24.
//

import Foundation

public struct FlightsUseCaseFactory {
    public static func makeListFlights(with repository: FlightsRepositoryProtocol) -> ListFlightsUseCaseProtocol {
        ListFlightsUseCase(repository: repository)
    }
    
    public static func makeGetNextFlightLeaving(with repository: FlightsRepositoryProtocol) -> GetNextFlightLeavingUseCaseProtocol {
        GetNextFlightLeavingUseCase(repository: repository)
    }
}
