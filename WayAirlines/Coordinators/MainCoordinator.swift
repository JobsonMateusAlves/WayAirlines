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
        tabBarController.setupAppearence()
        
        let homeNavController = UINavigationController()
        let flightsHistoryNavController = UINavigationController()
        
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: Images.home, tag: 0)
        flightsHistoryNavController.tabBarItem = UITabBarItem(title: "Voos", image: Images.airplane, tag: 1)
        
        startHome(navigationController: homeNavController)
        startFlightsHistory(navigationController: flightsHistoryNavController)
        
        tabBarController.viewControllers = [
            homeNavController,
            flightsHistoryNavController
        ]
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func startHome(navigationController: UINavigationController) {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func startFlightsHistory(navigationController: UINavigationController) {
        let coordinator = FlightsHistoryCoordinator(navigationController: navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
