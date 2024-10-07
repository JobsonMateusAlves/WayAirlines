//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import NetworkLayer

public protocol FlightsProviderProtocol {
    func list() async throws -> [Flight]
}

class FlightsProvider: Provider, FlightsProviderProtocol {
    
    func list() async throws -> [Flight] {
        let result = try await self.request(target: FlightsAPI.list, responseType: FlightsResponse.self)
        return result.flights
    }
}

public struct FlightsProviderFactory {
    public static func make(config: Configs = .network) -> FlightsProviderProtocol {
        FlightsProvider(session: config.session(by: "flights"))
    }
}
