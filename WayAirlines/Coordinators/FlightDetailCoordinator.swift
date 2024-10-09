//
//  FlightDetailCoordinator.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

class FlightDetailCoordinator: Coordinator {
    weak var parentCoordinator: PresentationLayer.Coordinator?
    var childCoordinators: [PresentationLayer.Coordinator] = []
    var navigationController: UINavigationController
    var flight: DomainLayer.Flight
    
    init(flight: DomainLayer.Flight, navigationController: UINavigationController) {
        self.flight = flight
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FlightDetailFactory.make(with: flight, coordinator: self)
        viewController.hidesBottomBarWhenPushed = true
        viewController.tabBarItem = UITabBarItem(title: "Voos", image: Images.airplane, tag: 1)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension FlightDetailCoordinator: FlightDetailViewModelDelegate {
    func close() {
        self.didFinishFlow(self)
        navigationController.popViewController(animated: true)
    }
}
