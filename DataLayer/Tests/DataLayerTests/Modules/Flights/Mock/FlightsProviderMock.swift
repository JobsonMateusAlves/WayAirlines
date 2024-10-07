//
//  File.swift
//
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import DataLayer

class FlightsProviderMock: FlightsProviderProtocol {
    private(set) var listCallCount = 0
    var listResult: [DataLayer.Flight] = []
    var listError: Error?
    
    func list() async throws -> [DataLayer.Flight] {
        listCallCount += 1
        if let listError {
            throw listError
        }
        
        return listResult
    }
}
