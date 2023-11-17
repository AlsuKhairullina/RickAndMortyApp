//
//  ProfileProtocols.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import Foundation

protocol ProfilePresenterInput: AnyObject {
    func viewDidLoad()
    func logOut()
}

protocol ProfilePresenterOutput: AnyObject {
    func setState(_: ViewState)
}
