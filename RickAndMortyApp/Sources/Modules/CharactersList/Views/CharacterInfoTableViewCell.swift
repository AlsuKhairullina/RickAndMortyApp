//
//  CharacterInfoTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 11.11.2023.
//

import Foundation
import UIKit

final class CharacterInfoTableViewCell: UITableViewCell {
    
    static let reuseId = "CharacterInfoTableViewCell"
    
    private lazy var nameLabel = UILabel()
    private lazy var episodeLabel = UILabel()
    
    func configureCell(with episode: EpisodeData) {
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = .clear
        
        nameLabel.text = episode.name
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.adjustsFontSizeToFitWidth = false
        nameLabel.lineBreakMode = .byTruncatingTail
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        episodeLabel.text = episode.episode
        episodeLabel.textColor = .black
        episodeLabel.font = .boldSystemFont(ofSize: 18)
        self.addSubview(episodeLabel)
        episodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
