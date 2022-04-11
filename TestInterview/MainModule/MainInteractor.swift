//
//  LoginInteractor.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import Foundation

class MainInteractor {
    var data: [PokemonData] = []
    private var offset = 0
    private let stepOffset = 20
    private let limit = 20
    
    init() { }
}

extension MainInteractor: MainInteractorProtocol {
    
    func fetchPokemon(by nameId: String, completion: @escaping ([PokemonData]) -> Void) {
        let completeUrlString = UrlString.api + UrlString.searchByNameId + nameId
        let offsetParam: Parameter = (key: "offset", value: String(offset))
        let limitParam: Parameter = (key: "limit", value: String(limit))
        ConnectionManager.request(from: completeUrlString, params: offsetParam, limitParam) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .failure:
                completion([])
            case .success(let data):
                let decoder = JSONDecoder()
                if nameId.isEmpty {
                    let decodedData: PokemonSearch? = try? decoder.decode(PokemonSearch.self, from: data)
                    let data = decodedData?.results ?? []
                    if self.offset == 0 {
                        self.data = data
                    } else {
                        self.data.append(contentsOf: data)
                    }
                    
                    self.offset += self.stepOffset
                } else {
                    let decodedData: PokemonModel? = try? decoder.decode(PokemonModel.self, from: data)
                    self.data = [decodedData].compactMap { $0 }
                    self.offset = 0
                }
                completion(self.data)
            }
        }
    }
    
    func fetchPokemon(type: PokemonTypes, completion: @escaping ([PokemonData]) -> Void) {
        let type = type.rawValue
        let completeUrlString = UrlString.api + UrlString.searchByType + type
        ConnectionManager.request(from: completeUrlString) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .failure:
                completion([])
            case .success(let data):
                let decoder = JSONDecoder()
                let result: PokemonTypeModel? = try? decoder.decode(PokemonTypeModel.self, from: data)
                self.data = result?.pokemon ?? []
                completion(self.data)
            }
        }
    }
}
