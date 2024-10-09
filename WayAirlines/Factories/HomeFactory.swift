//
//  HomeFactory.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

extension HomeFactory {
    static func make(coordinator: (Coordinator & HomeViewModelDelegate)) -> UIViewController {
        let provider = FlightsDataFactory.makeProvider(config: .mock)
        let repository = FlightsDataFactory.makeRepository(with: provider)
        let useCase = FlightsUseCaseFactory.makeGetNextFlightLeaving(with: repository)
        let viewModel = makeViewModel(with: useCase, coordinator: coordinator)
        return makeController(viewModel: viewModel)
    }
}
