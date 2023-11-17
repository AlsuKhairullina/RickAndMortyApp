//
//  CharactersPresenter.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import Foundation

final class CharactersPresenter: CharactersPresenterInput {
    
    weak var view: CharactersViewController?
    weak var coordinator: CharactersCoordinator?
    private var apiManager: APIService
    private var isLoadingMoreCharacters = false
    
    init(
        coordinator: CharactersCoordinator,
        apiManager: APIService
    )
    {
        self.coordinator = coordinator
        self.apiManager = apiManager
    }
    
    func viewDidLoad() {
        view?.setState(.start)
    }
    
    /// Fetches characters from page parametr and reloads TableView.
    func fetchCharacters(from page: Int) {
        apiManager.fetchCharacters(from: page) { [weak self] charas in
            DispatchQueue.main.async {
                guard let self else { return }
                self.view?.characters = charas
                self.view?.collectionView.reloadData()
            }
        }
    }
    
    /// Fetches more characters from page parametr for collection view when user reaches the end of collection view.
    func fetchMoreCharacters(from page: Int) {
        apiManager.fetchCharacters(from: page) { [weak self] moreCharas in
            guard let strongSelf = self else {
                return
            }
            guard let originalCount = self?.view?.characters.count else { return }
            let newCount = moreCharas.count
            let total = originalCount  + newCount
            let startingIndex = total - newCount
            let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                return IndexPath(row: $0, section: 0)
            })
            self?.view?.characters.append(contentsOf: moreCharas)
            DispatchQueue.main.async {
                strongSelf.didLoadMoreCharacters(
                    with: indexPathsToAdd
                )
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
    ///  Updates the collection view by adding new cells.
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        view?.collectionView.performBatchUpdates {
            view?.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    /// Navigate user to character info module.
    func didSelectItem(character: CharacterData) {
        coordinator?.navigate(with: .characterInfo(character: character))
    }
}
