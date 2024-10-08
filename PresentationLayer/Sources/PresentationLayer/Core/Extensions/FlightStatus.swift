//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import UIKit
import DomainLayer

extension DomainLayer.Flight.Status {
    var color: UIColor {
        switch self {
        case .completed:
            return Colors.tagGreenColor
        case .canceled:
            return Colors.tagRedColor
        }
    }
}
