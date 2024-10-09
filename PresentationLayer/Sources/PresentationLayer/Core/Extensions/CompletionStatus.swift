//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import DomainLayer

extension Flight.CompletionStatus {
    var color: UIColor {
        switch self {
        case .onTime:
            return Colors.tagGreenColor
        case .delayed:
            return Colors.tagYellowColor
        case .canceled:
            return Colors.tagRedColor
        }
    }
    
    var value: String {
        switch self {
        case .onTime:
            return "No horário"
        case .delayed:
            return "Atrasou"
        case .canceled:
            return "Cancelado"
        }
    }
}
