//
//  LogInViewController.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 05.11.2023.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController {
    
    var presenter: LogInPresenterInput?
    private lazy var loginLabel = UILabel()
    private lazy var usernameTextField = RoundedTextField()
    private lazy var passwordTextField = RoundedTextField()
    private lazy var loginButton = UIButton()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        
        view.backgroundColor = .white
        
        loginLabel.textColor = UIColor.darkGreen
        loginLabel.text = "Авторизация"
        loginLabel.font = .boldSystemFont(ofSize: 42)
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(90)
        }
        
        let loginTextField = usernameTextField
        loginTextField.placeholder = "Логин"
        loginTextField.autocorrectionType = .no
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
        }
        
        let passwordTextField = passwordTextField
        passwordTextField.placeholder = "Пароль"
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(loginTextField.snp.bottom).offset(20)
        }
        
        let loginButton = loginButton
        loginButton.backgroundColor = UIColor.darkGreen
        loginButton.createButton(buttonTilte: "Авторизация")
        loginButton.addTarget(self, action: #selector(didTappedLogIn), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func didTappedLogIn() {
        if usernameTextField.text != nil && passwordTextField.text != nil {
            guard let username = usernameTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            presenter?.logIn(username: username, password: password)
        }
    }
}

// MARK: View Controller extensions
extension LogInViewController: LogInPresenterOutput {
   
    func setState(_ state: ViewState) {
        switch state {
        case .done:
            self.view.backgroundColor = .green
        case .start:
            self.view.backgroundColor = .systemTeal
        case .failure:
            self.view.backgroundColor = .red
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка авторизации", message: "Неверный логин или пароль", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
