//
//  AuthCoordinator.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 17.10.2023.
//

import Foundation
import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    
    private var parentCoordinator: AppCoordinator
    private let navigationController = UINavigationController()
    
    init(parentCoordinator: AppCoordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    enum AuthFlow {
        case signUp
        case logIn
    }
    
    func navigate(with route: AuthFlow) {
        switch route {
            case .signUp:
            let presenter = SignUpPresenter(coordinator: self, authManager: KeychainService())
            let vc = SignUpViewController()
            presenter.view = vc
            vc.presenter = presenter
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(vc, animated: true)
            case .logIn:
            let presenter = LogInPresenter(coordinator: self, authManager: KeychainService())
            let vc = LogInViewController()
            presenter.view = vc
            vc.presenter = presenter
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func finishAuthFlow() {
        parentCoordinator.finishAuthFlow()
    }
    
    func configureMainController() -> UIViewController {
        navigate(with: .signUp)
        navigationController.navigationBar.tintColor = .darkGreen
        return navigationController
    }
}
