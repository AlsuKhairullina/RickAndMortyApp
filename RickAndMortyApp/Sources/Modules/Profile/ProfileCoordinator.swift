//
//  ProfileCoordinator.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import UIKit

final class ProfileCoordinator: CoordinatorProtocol {
 
    var parentCoordinator: TabBarCoordinator
    private let navigationController = UINavigationController()
    
    init(parentCoordinator: TabBarCoordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    enum ProfileFlow {
        case profile
    }
    
    func navigate(with route: ProfileFlow) {
        switch route {
        case .profile:
            let presenter = ProfilePresenter(coordinator: self, authManager: KeychainService())
            let vc = ProfileViewController()
            vc.presenter = presenter
            presenter.view = vc
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    /// Starts Profile flow.
    func start() {
        navigate(with: .profile)
    }
    
    func endSession() {
        parentCoordinator.endSession()
    }
    
    func configureMainController() -> UIViewController {
        navigate(with: .profile)
        return navigationController
    }
}
