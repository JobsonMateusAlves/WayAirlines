//
//  FlightsHistoryCoordinator.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

class FlightsHistoryCoordinator: Coordinator {
    weak var parentCoordinator: PresentationLayer.Coordinator?
    var childCoordinators: [PresentationLayer.Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FlightsHistoryFactory.make()
        navigationController.setViewControllers([viewController], animated: false)
    }
}
