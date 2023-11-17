//
//  ProfilePresenter.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import Foundation

final class ProfilePresenter: ProfilePresenterInput {
    
    weak var view: ProfileViewController?
    weak var coordinator: ProfileCoordinator?
    private var authManager: KeychainService
    
    init(
        coordinator: ProfileCoordinator,
        authManager: KeychainService
    )
    {
        self.coordinator = coordinator
        self.authManager = authManager
        
    }
    
    func viewDidLoad() {
        view?.setState(.start)
    }
    
    func logOut() {
        authManager.logOut()
        coordinator?.endSession()
    }
}
