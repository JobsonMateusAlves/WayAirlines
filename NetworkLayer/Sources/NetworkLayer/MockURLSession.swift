//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public class MockURLSession: URLSessionProtocol {
    private let fileName: String
    private let bundle: Bundle

    public init(fileName: String, bundle: Bundle) {
        self.fileName = fileName
        self.bundle = bundle
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
              let requestURL = request.url,
              let response = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        else {
            throw NSError(
                domain: "MockError",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "File not found or invalid RequestURL"
                ]
            )
        }

        let data = try Data(contentsOf: url)
        return (data, response)
    }
}
