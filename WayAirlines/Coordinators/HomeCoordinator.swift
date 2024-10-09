//
//  HomeCoordinator.swift
//  WayAirlines
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit
import PresentationLayer
import DomainLayer
import DataLayer

class HomeCoordinator: Coordinator {
    weak var parentCoordinator: PresentationLayer.Coordinator?
    var childCoordinators: [PresentationLayer.Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeFactory.make(coordinator: self)
        viewController.hidesBottomBarWhenPushed = false
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    
}
