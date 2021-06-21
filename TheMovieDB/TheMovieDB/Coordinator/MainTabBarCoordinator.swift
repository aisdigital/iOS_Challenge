//
//  MainTabBarCoordinator.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let controller = MainTabController()
        presenter.pushViewController(controller, animated: false)
    }
    
}
