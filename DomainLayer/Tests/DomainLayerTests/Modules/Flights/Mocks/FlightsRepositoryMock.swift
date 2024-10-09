//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import Foundation
import DomainLayer

class FlightsRepositoryMock: FlightsRepositoryProtocol {
    
    var flights: [Flight] = []
    
    func list() async throws -> [DomainLayer.Flight] {
        flights
    }
}
