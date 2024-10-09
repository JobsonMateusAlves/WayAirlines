//
//  FlightsHistoryFactory.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

extension FlightsHistoryFactory {
    static func make(coordinator: (Coordinator & FlightsHistoryViewModelDelegate)) -> UIViewController {
        let provider = FlightsDataFactory.makeProvider(config: .mock)
        let repository = FlightsDataFactory.makeRepository(with: provider)
        let useCase = FlightsUseCaseFactory.makeListFlights(with: repository)
        let viewModel = makeViewModel(with: useCase, coordinator: coordinator)
        return makeController(viewModel: viewModel)
    }
}
