//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import DomainLayer

public struct HomeFactory {
    public static func makeController(viewModel: HomeViewModelProtocol) -> UIViewController {
        HomeViewController(viewModel: viewModel)
    }
    
    public static func makeViewModel(with useCase: GetNextFlightLeavingUseCaseProtocol, coordinator: (Coordinator & HomeViewModelDelegate)) -> HomeViewModelProtocol {
        HomeViewModel(useCase: useCase, coordinator: coordinator)
    }
}
