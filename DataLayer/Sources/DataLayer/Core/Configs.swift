//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import NetworkLayer

public enum Configs {
    case network
    case mock
}

extension Configs {
    func session(by fileName: String) -> URLSessionProtocol {
        switch self {
        case .mock:
            return MockURLSession(fileName: fileName, bundle: .module)
        case .network:
            return URLSession.shared
        }
    }
}
