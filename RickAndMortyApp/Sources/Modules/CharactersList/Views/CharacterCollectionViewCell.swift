//
//  CharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 06.11.2023.
//

import UIKit
import SnapKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CharacterCollectionViewCell"
    
    private lazy var nameLabel = UILabel()
    private lazy var status = UILabel()
    private lazy var statusLabel = UILabel()
    private lazy var gender = UILabel()
    private lazy var genderLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCell(with character: CharacterData) {
        
        self.clipsToBounds = true
        
        imageView.downloaded(from: character.image)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.0/1.0)
        }
        
        nameLabel.text = character.name
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textColor = .darkGreen
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
        }
        
        status.text = "Status: "
        status.textColor = .darkGray
        self.addSubview(status)
        status.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            
        }
        
        statusLabel.text = character.status
        statusLabel.textColor = .darkGray
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(status.snp.trailing).offset(5)
        }
        
        gender.text = "Gender: "
        gender.textColor = .darkGray
        self.addSubview(gender)
        gender.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
        }
        
        genderLabel.text = character.gender
        genderLabel.textColor = .darkGray
        self.addSubview(genderLabel)
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.leading.equalTo(gender.snp.trailing).offset(5)
        }
    }
}
