//
//  File.swift
//  
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit
import DomainLayer

public struct FlightsHistoryFactory {
    public static func makeController(viewModel: FlightsHistoryViewModelProtocol) -> UIViewController {
        FlightsHistoryViewController(viewModel: viewModel)
    }
    
    public static func makeViewModel(with useCase: ListFlightsUseCaseProtocol, coordinator: (Coordinator & FlightsHistoryViewModelDelegate)) -> FlightsHistoryViewModelProtocol {
        FlightsHistoryViewModel(useCase: useCase, coordinator: coordinator)
    }
}
