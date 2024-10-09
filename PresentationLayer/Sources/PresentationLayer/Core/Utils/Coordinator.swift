//
//  File.swift
//  
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit

public protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func didFinishFlow(_ child: Coordinator)
}

public extension Coordinator {
    func didFinishFlow(_ child: Coordinator) {
        self.parentCoordinator?.childCoordinators.removeAll(where: { $0 === child })
    }
}

