//
//  FlightDetailFactory.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

extension FlightDetailFactory {
    static func make(with flight: DomainLayer.Flight, coordinator: (Coordinator & FlightDetailViewModelDelegate)) -> UIViewController {
        let viewModel = makeViewModel(with: flight, coordinator: coordinator)
        return makeController(viewModel: viewModel)
    }
}
