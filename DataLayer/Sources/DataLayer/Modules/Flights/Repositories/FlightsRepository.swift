//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import DomainLayer

public class FlightsRepository: FlightsRepositoryProtocol {
    let provider: FlightsProviderProtocol
    
    public init(provider: FlightsProviderProtocol) {
        self.provider = provider
    }
    
    public func list() async throws -> [DomainLayer.Flight] {
        let result = try await self.provider.list().map({ $0.toDomain() })
        return result
    }
}
