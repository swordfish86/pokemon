//
//  DetailInteractor.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import Foundation

class DetailInteractor {
    private var pokemonId: Int
    var pokemonData: PokemonModel?
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func fetchPokemon(completion: @escaping (PokemonModel?) -> Void) {
        let completeUrlString = UrlString.api + UrlString.searchByNameId + String(pokemonId)
        ConnectionManager.request(from: completeUrlString) { response in
            switch response {
            case .failure:
                completion(nil)
            case .success(let data):
                let decoder = JSONDecoder()
                let decodedData: PokemonModel? = try? decoder.decode(PokemonModel.self, from: data)
                self.pokemonData = decodedData
                completion(decodedData)
            }
        }
    }
}
