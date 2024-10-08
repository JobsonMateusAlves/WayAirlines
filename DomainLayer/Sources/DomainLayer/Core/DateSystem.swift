//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

class DateSystem {
    static let shared: DateSystem = {
        DateSystem()
    }()
    
    private var date: Date?
    
    private init() {}
    
    func getNow() -> Date {
        date ?? Date()
    }
}
