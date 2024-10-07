//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public protocol FlightsRepositoryProtocol {
    func list() async throws -> [Flight]
}
