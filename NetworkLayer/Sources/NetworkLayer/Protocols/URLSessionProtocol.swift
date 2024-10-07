//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
