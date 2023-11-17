//
//  TabBarCoordinator.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 30.10.2023.
//

import Foundation
import UIKit

final class TabBarCoordinator: CoordinatorProtocol {
    
    /// TabBar Flow.
    enum TabFlow{
        case charactersListScreen
        case profileScreen
    }
    
    var parentCoordinator: AppCoordinator
    private lazy var charactersCoordinator: CharactersCoordinator = CharactersCoordinator(parentCoordinator: self)
    private lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator(parentCoordinator: self)
    lazy var rootViewController = UITabBarController()
    
    init(parentCoordinator: AppCoordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    func navigate(with route: TabFlow) {
        switch route {
        case .charactersListScreen:
            rootViewController.selectedIndex = 0
        case .profileScreen:
            rootViewController.selectedIndex = 1
        }
    }
    
    func configureMainController() -> UIViewController {
        
        let config = UIImage.SymbolConfiguration(weight: .bold)
        
        let charactersViewController = charactersCoordinator.configureMainController()
        charactersCoordinator.parentCoordinator = self
        let boldList = UIImage(systemName: "text.justify", withConfiguration: config)
        charactersViewController.tabBarItem = UITabBarItem(title: "Персонажи", image: boldList, selectedImage: nil)
        
        let boldPerson = UIImage(systemName: "person", withConfiguration: config)
        let profileViewController = profileCoordinator.configureMainController()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image:boldPerson, selectedImage: nil)
        
        rootViewController.tabBar.backgroundColor = .darkGreen
        rootViewController.tabBar.tintColor = .customWhite
        
        rootViewController.viewControllers = [charactersViewController, profileViewController]
        navigate(with: .charactersListScreen)
        return rootViewController
    }
    
    /// Tells ProfileCoordinator the session ended.
    func endSession() {
        parentCoordinator.endSessionFlow()
    }
}
