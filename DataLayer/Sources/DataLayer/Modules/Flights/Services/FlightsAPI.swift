//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import NetworkLayer

enum FlightsAPI {
    case list
}

extension FlightsAPI: API {
    var baseURL: String {
        "www.fligths.com"
    }
    
    var path: String {
        "/list"
    }
    
    var method: NetworkLayer.HTTPMethod {
        .GET
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var body: Data? {
        nil
    }
}
