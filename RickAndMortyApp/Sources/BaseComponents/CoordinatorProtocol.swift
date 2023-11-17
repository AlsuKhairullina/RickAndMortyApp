//
//  CoordinatorProtocol.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 17.10.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    associatedtype Route 
    func navigate(with route: Route)
    func configureMainController() -> UIViewController
}

extension CoordinatorProtocol {
    func configureMainController() -> UIViewController {
        assertionFailure("Дефолтная реализация не должна использоваться")
        return UIViewController()
    }
}
