//
//  CharacterInfoViewController.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 10.11.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    var episodes = [EpisodeData]()
    var presenter: CharacterInfoPresenterInput?
    private lazy var infoLabel = UILabel()
    private lazy var nameLabel = UILabel()
    private lazy var imageView = UIImageView()
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        configureView()
        presenter?.fetchEpisodes()
        tableView.register(CharacterInfoTableViewCell.self, forCellReuseIdentifier: CharacterInfoTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureView() {
        
        view.backgroundColor = .white
        
        infoLabel.text = "Информация"
        infoLabel.font = .boldSystemFont(ofSize: 32)
        infoLabel.textColor = .darkGreen
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        
        guard let imageUrl = presenter?.character?.image else { return }
        imageView.downloaded(from: imageUrl)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.0/1.0)
        }
        
        nameLabel.text = presenter?.character?.name
        nameLabel.textColor = .darkGreen
        nameLabel.font = .boldSystemFont(ofSize: 26)
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(5)
        }
    }
}

extension CharacterInfoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoTableViewCell.reuseId, for: indexPath) as? CharacterInfoTableViewCell
        else {
            fatalError("Failed")
        }
        cell.configureCell(with: episodes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension CharacterInfoViewController: CharacterInfoPresenterOutput {
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
