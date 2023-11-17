//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 13.11.2023.
//

import Foundation
import Alamofire

// MARK: - CharacterData
struct CharacterData: Decodable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
}

struct CharactersResponse: Decodable {
    let info: InfoData
    let results: [CharacterData]
}

struct InfoData: Decodable {
    let count: Int
}

// MARK: Episode Data
struct EpisodeData: Decodable {
    let id: Int
    let name: String
    let episode: String
    var url: String
}

struct EpisodeResponse: Decodable {
    let info: InfoData
    let results: [EpisodeData]
}

// MARK: API Service Protocols
protocol APIServiceProtocols: AnyObject {
    func fetchCharacters(from page: Int, completion: @escaping (([CharacterData]) ->()))
    func fetchEpisodesForCharacter(character: CharacterData, completion: @escaping (([EpisodeData]) ->()))
}

final class APIService: APIServiceProtocols {
    
    /// Fetches all episodes from API for a specific character from its array of episodes.
    func fetchEpisodesForCharacter(character: CharacterData, completion: @escaping (([EpisodeData]) ->())) {
        
        var result = [EpisodeData]()
        let charEpisodesURLs = character.episode
        
        for url in charEpisodesURLs {
            let url = URL(string: url)!
            let requset = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: requset) { data, response, err in
                if let responseData = data {
                    do {
                        let episodeResponse = try JSONDecoder().decode(EpisodeData.self, from: responseData)
                        result.append(episodeResponse)
                        completion(result)
                    } catch let err {
                        print(err.localizedDescription)
                        return
                    }
                }
            }.resume()
        }
    }
    
    /// Fetches all characters from API from specific page.
    func fetchCharacters(from page: Int, completion: @escaping (([CharacterData]) ->())) {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, err in
            if let responseData = data {
                do {
                    let charactersResponse = try JSONDecoder().decode(CharactersResponse.self, from: responseData)
                    completion(charactersResponse.results)
                } catch let err {
                    print(err.localizedDescription)
                    return
                }
            }
        }.resume()
    }
}

extension UIImageView {
    
    /// Extension for UIImageView to convert String to UIImageView from URL.
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

