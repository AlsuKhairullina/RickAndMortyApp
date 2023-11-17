//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 17.10.2023.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {

    /// Main coordinator flow.
    enum AppFlow {
        case authScreen
        case charactersListScreen
    }
    
    private lazy var authCoordinator = AuthCoordinator(parentCoordinator: self)
    private lazy var tabBarCoordinator = TabBarCoordinator(parentCoordinator: self)
    private lazy var authService = KeychainService()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(with route: AppFlow) {
        switch route {
        case .authScreen:
            setRootViewController(authCoordinator.configureMainController(), duration: 0.5)
        case .charactersListScreen:
            setRootViewController(tabBarCoordinator.configureMainController(), duration: 0.5)
        }
    }
    
    /// Starts the app flow.
    func start() {
        if (authService.isLoggedIn()) {
            navigate(with: .authScreen)
        } else {
            navigate(with: .charactersListScreen)
        }
    }

    func finishAuthFlow() {
        navigate(with: .charactersListScreen)
    }
    
    func endSessionFlow() {
        navigate(with: .authScreen)
    }
    func setRootViewController(_ vc: UIViewController, duration: TimeInterval) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: duration,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
