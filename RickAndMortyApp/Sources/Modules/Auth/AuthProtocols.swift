//
//  AuthProtocols.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 31.10.2023.
//

import Foundation

protocol SignUpPresenterInput: AnyObject {
    func viewDidLoad()
    func goToLoginScreen()
    func signUp(username: String, password: String)
}

protocol SignUpPresenterOutput: AnyObject {
    func setState(_: ViewState)
    func showAlert()
}

protocol LogInPresenterInput: AnyObject {
    func viewDidLoad()
    func logIn(username: String, password: String)
}

protocol LogInPresenterOutput: AnyObject {
    func setState(_: ViewState)
    func showAlert()
}
