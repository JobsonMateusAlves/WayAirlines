//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import DomainLayer

public struct FlightDetailFactory {
    public static func makeController(viewModel: FlightDetailViewModelProtocol) -> UIViewController {
        FlightDetailViewController(viewModel: viewModel)
    }
    
    public static func makeViewModel(with flight: Flight, coordinator: (Coordinator & FlightDetailViewModelDelegate)) -> FlightDetailViewModelProtocol {
        FlightDetailViewModel(flight: flight, coordinator: coordinator)
    }
}
