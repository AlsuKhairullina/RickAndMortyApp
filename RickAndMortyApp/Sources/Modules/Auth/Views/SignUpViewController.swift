//
//  SignUpViewController.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 05.11.2023.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterInput?
    private lazy var signupLabel = UILabel()
    private lazy var contentView = UIView()
    private lazy var alreadyHave = UILabel()
    private lazy var transButton = UIButton()
    private lazy var usernameTextField = RoundedTextField()
    private lazy var passwordTextField = RoundedTextField()
    private lazy var signupButton = UIButton()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
                
        view.backgroundColor = .white
        
        let signupLabel = signupLabel
        signupLabel.textColor = UIColor.darkGreen
        signupLabel.text = "Регистрация"
        signupLabel.font = .boldSystemFont(ofSize: 42)
        view.addSubview(signupLabel)
        signupLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(90)
        }
    
        let alreadyHave = alreadyHave
        alreadyHave.textColor = UIColor.gray
        alreadyHave.text = "Уже есть аккаунт?"
        alreadyHave.font = .boldSystemFont(ofSize: 18)
        view.addSubview(alreadyHave)
        alreadyHave.snp.makeConstraints { make in
            make.leading.equalTo(signupLabel.snp.leading).inset(10)
            make.top.equalTo(signupLabel.snp.bottom).offset(20)
        }
        
        let transButton = transButton
        transButton.setTitle("Войти", for: .normal)
        transButton.setTitleColor(.darkGreen, for: .normal)
        transButton.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .bold)
        transButton.addTarget(self, action: #selector(didTappedTransButton), for: .touchUpInside)
        view.addSubview(transButton)
        transButton.snp.makeConstraints { make in
            make.trailing.equalTo(signupLabel.snp.trailing).offset(-10)
            make.top.equalTo(signupLabel.snp.bottom).offset(14 )
        }
        
        let usernameTextField = usernameTextField
        usernameTextField.placeholder = "Логин"
        usernameTextField.autocorrectionType = .no
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(alreadyHave.snp.bottom).offset(20)
        }
        
        let passwordTextField = passwordTextField
        passwordTextField.placeholder = "Пароль"
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }
        
        let signupButton = signupButton
        signupButton.backgroundColor = UIColor.darkGreen
        signupButton.createButton(buttonTilte: "Регистрация")
        signupButton.addTarget(self, action: #selector(didTappedSignUp), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc private func didTappedTransButton() {
        presenter?.goToLoginScreen()
    }
    
    @objc func didTappedSignUp() {
        if usernameTextField.text != nil && passwordTextField.text != nil {
            guard let username = usernameTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            presenter?.signUp(username: username, password: password)
        }
    }
}

// MARK: View Controller extensions
extension SignUpViewController: SignUpPresenterOutput {
   
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
        let alert = UIAlertController(title: "Ошибка регистрации", message: "Введите логин и пароль", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

