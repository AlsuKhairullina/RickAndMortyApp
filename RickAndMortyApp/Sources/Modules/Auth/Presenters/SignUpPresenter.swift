//
//  SignUpPresenter.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 05.11.2023.
//

import Foundation

final class SignUpPresenter: SignUpPresenterInput {
   
    weak var view: SignUpPresenterOutput?
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
    
    func goToLoginScreen() {
        coordinator?.navigate(with: .logIn)
    }
    
    func signUp(username: String, password: String) {
        let result = authManager.signUp(username: username, password: password)
        switch result {
        case .success:
            coordinator?.finishAuthFlow()
        case .error:
            view?.showAlert()
        }
    }
}
