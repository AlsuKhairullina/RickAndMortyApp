//
//  ProfileViewController.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterInput?
    private lazy var logoutButton = UIButton()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        view.backgroundColor = .white

        logoutButton = UIButton()
        logoutButton.createButton(buttonTilte: "Выйти")
        logoutButton.backgroundColor = .darkGreen
        logoutButton.addTarget(self, action: #selector(didTappedLogOut), for: .touchUpInside)
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    @objc func didTappedLogOut() {
        self.dismiss(animated: true)
        presenter?.logOut()
    }
}

// MARK: View Controller extensions
extension ProfileViewController: ProfilePresenterOutput {
   
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
}
