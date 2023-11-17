//
//  LogInPresenter.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 05.11.2023.
//

import Foundation

final class LogInPresenter: LogInPresenterInput {
    
    weak var view: LogInPresenterOutput?
    weak var coordinator: AuthCoordinator?
    private var authManager: KeychainService
    
    init(
        coordinator: AuthCoordinator,
        authManager: KeychainService
    )
    {
        self.coordinator = coordinator
        self.authManager = authManager
        
    }
    
    func viewDidLoad() {
        view?.setState(.start)
    }
    
    func logIn(username: String, password: String) {
        let result = authManager.logIn(username: username, password: password)
        switch result {
        case .success:
            coordinator?.finishAuthFlow()
        case .error:
            view?.showAlert()
        }
    }
}
