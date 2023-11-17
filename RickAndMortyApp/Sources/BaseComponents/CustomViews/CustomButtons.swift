//
//  CustomButtons.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 16.11.2023.
//

import UIKit

extension UIButton {
    func createButton(buttonTilte: String) {
        let button = self
        button.setTitle(buttonTilte, for: .normal)
        button.tintColor = UIColor.customWhite
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
       }
}

