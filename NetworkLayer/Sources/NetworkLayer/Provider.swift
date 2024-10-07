//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

open class Provider {
    let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func request<T>(target: API, responseType: T.Type) async throws -> T where T : Decodable {
        let request = try makeRequest(with: target)
        
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(responseType.self, from: data)
    }
    
    private func makeRequest(with target: API) throws -> URLRequest {
        guard let url = target.url else {
            throw NetworkError.invalidURL
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.httpBody = target.body
        
        return request
    }
}
