//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public protocol API {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var url: URL? { get }
}

extension API {
    public var url: URL? {
        URL(string: baseURL + path)
    }
}
