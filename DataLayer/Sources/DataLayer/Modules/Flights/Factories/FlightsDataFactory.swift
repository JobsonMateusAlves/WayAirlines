//
//  File.swift
//  
//
//  Created by Jobson Mateus on 08/10/24.
//

import Foundation
import DomainLayer

public struct FlightsDataFactory {
    public static func makeRepository(with provider: FlightsProviderProtocol) -> FlightsRepositoryProtocol {
        FlightsRepository(provider: provider)
    }
    
    public static func makeProvider(config: Configs) -> FlightsProviderProtocol {
        FlightsProvider(session: config.session(by: "flights"))
    }
}

