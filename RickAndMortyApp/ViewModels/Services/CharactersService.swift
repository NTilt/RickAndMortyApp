//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 17.08.2023.
//

import Foundation

enum CharacterError: Error {
    case BadURL
    case BadData
    case DecodingError
}

class CharactersService {
    
    func getCharacters(url: String, completion: @escaping(Result<CharacterJSON?, CharacterError>) -> Void) {
        
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.BadData))
            }
            let characterResponse = try? JSONDecoder().decode(CharacterJSON.self, from: data)
            if let characterResponse = characterResponse {
                completion(.success(characterResponse))
            }
            else {
                completion(.failure(.DecodingError))
            }
        }
        .resume()
    }
}
