//
//  CharacterInfoPresenter.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 10.11.2023.
//

import Foundation

final class CharacterInfoPresenter: CharacterInfoPresenterInput {
        
    weak var view: CharacterInfoViewController?
    weak var coordinator: CharactersCoordinator?
    private var apiManager: APIService
    var character: CharacterData?
    
    
    init(
        coordinator: CharactersCoordinator,
        character: CharacterData,
        apiManager: APIService)
    {
        self.coordinator = coordinator
        self.character = character
        self.apiManager = apiManager
    }
    
    func viewDidLoad() {
        view?.setState(.start)
    }
    
    ///  Fetches all episodes for character and reloads TableView.
    func fetchEpisodes() {
        apiManager.fetchEpisodesForCharacter(character: character!) { [weak self] episodes in
            DispatchQueue.main.async {
                guard let self else { return }
                self.view?.episodes = episodes
                self.view?.tableView.reloadData()
            }
        }
    }
}
