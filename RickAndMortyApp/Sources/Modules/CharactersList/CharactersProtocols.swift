//
//  CharactersProtocols.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import Foundation

protocol CharactersPresenterInput: AnyObject {
    func viewDidLoad()
    func fetchCharacters(from page: Int)
    func fetchMoreCharacters(from page: Int)
    func didSelectItem(character: CharacterData)
}

protocol CharacterInfoPresenterInput: AnyObject {
    func viewDidLoad()
    var character: CharacterData? { get }
    func fetchEpisodes()
}

protocol CharactersPresenterOutput: AnyObject {
    func setState(_: ViewState)
}

protocol CharacterInfoPresenterOutput: AnyObject {
    func setState(_: ViewState)
}
