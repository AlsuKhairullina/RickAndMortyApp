//
//  CharactersCoordinator.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import UIKit

final class CharactersCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: TabBarCoordinator
    private let navigationController = UINavigationController()
    
    init(parentCoordinator: TabBarCoordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    enum CharactersListFlow {
        case charactersList
        case characterInfo(character: CharacterData)
    }
    
    func navigate(with route: CharactersListFlow) {
        switch route {
        case .charactersList:
            let presenter = CharactersPresenter(coordinator: self, apiManager: APIService())
            let vc = CharactersViewController()
            presenter.view = vc
            vc.presenter = presenter
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(vc, animated: true)
        case .characterInfo(let character):
            let presenter = CharacterInfoPresenter(coordinator: self, character: character, apiManager: APIService())
            let vc = CharacterInfoViewController()
            presenter.view = vc
            vc.presenter = presenter
            navigationController.present(vc, animated: true)
        }
    }
    
    func start() {
        navigate(with: .charactersList)
    }
    
    func configureMainController() -> UIViewController {
        navigate(with: .charactersList)
        return navigationController
    }
}
