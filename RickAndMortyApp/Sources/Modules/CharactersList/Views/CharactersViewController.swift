//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import UIKit
import SnapKit

final class CharactersViewController: UIViewController {
    
    var characters = [CharacterData]()
    var currentPage = 1
    var totalPages = 42
    var presenter: CharactersPresenterInput?
    private lazy var charactersLabel = UILabel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        presenter?.fetchCharacters(from: 1)
        configureView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        charactersLabel = charactersLabel
        charactersLabel.text = "Персонажи"
        charactersLabel.textColor = UIColor.darkGreen
        charactersLabel.font = .boldSystemFont(ofSize: 30)
        view.addSubview(charactersLabel)
        charactersLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(20)
        }
        
        collectionView = collectionView
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(charactersLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(5)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseId, for: indexPath) as? CharacterCollectionViewCell
        else {
            fatalError("Failed")
        }
        cell.configureCell(with: characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        presenter?.didSelectItem(character: character)
    }
    
    /// Divides collection view into two column.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 5
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 250)
    }
    
    /// Detects if user is dragging the end of collection view.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            currentPage += 1
            presenter?.fetchMoreCharacters(from: currentPage)
        }
    }
}

// MARK: View Controller extensions
extension CharactersViewController: CharactersPresenterOutput {
    
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
