//
//  MainCoordinator.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit
import PresentationLayer

class MainCoordinator: Coordinator {
    weak var parentCoordinator: PresentationLayer.Coordinator?
    var childCoordinators: [PresentationLayer.Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController.hidesBottomBarWhenPushed = true
        
        startFlightsHistory()

        tabBarController.viewControllers = self.childCoordinators.map({
            $0.navigationController
        })
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func startFlightsHistory() {
        let coordinator = FlightsHistoryCoordinator(navigationController: UINavigationController())
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
