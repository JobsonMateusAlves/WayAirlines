//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import DomainLayer

class FlightsRepository: FlightsRepositoryProtocol {
    let provider: FlightsProviderProtocol
    
    init(provider: FlightsProviderProtocol) {
        self.provider = provider
    }
    
    func list() async throws -> [DomainLayer.Flight] {
        let result = try await self.provider.list().map({ $0.toDomain() })
        return result
    }
}
