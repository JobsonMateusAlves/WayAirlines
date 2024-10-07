//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import NetworkLayer

protocol FlightsProviderProtocol {
    func getFlights() async throws -> [Flight]
}

class FlightsProvider: Provider, FlightsProviderProtocol {
    
    func getFlights() async throws -> [Flight] {
        let result = try await self.request(target: FlightsAPI.list, responseType: FlightsResponse.self)
        return result.flights
    }
}

struct FlightsProviderFactory {
    static func make(config: Configs = .network) -> FlightsProviderProtocol {
        FlightsProvider(session: config.session(by: "flights"))
    }
}
