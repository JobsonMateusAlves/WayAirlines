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
        let viewController = FlightsHistoryFactory.make(coordinator: self)
        viewController.hidesBottomBarWhenPushed = false
        viewController.tabBarItem = UITabBarItem(title: "Voos", image: Images.airplane, tag: 1)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func startFlightDetail(flight: DomainLayer.Flight) {
        let coordinator = FlightDetailCoordinator(flight: flight, navigationController: navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension FlightsHistoryCoordinator: FlightsHistoryViewModelDelegate {
    func didSelect(flight: DomainLayer.Flight) {
        startFlightDetail(flight: flight)
    }
}
