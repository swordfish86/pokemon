//
//  DetailPresenter.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import UIKit

class DetailPresenter {
    private var interactor: DetailInteractorProtocol
    private var wireframe: DetailWireframeProtocol
    weak var delegate: MainFlowProtocol?
    
    init(interactor: DetailInteractorProtocol,
         wireframe: DetailWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    var pokemonData: PokemonModel? {
        interactor.pokemonData
    }
    
    func present(navController: UINavigationController) {
        wireframe.present(presenter: self, navController: navController)
    }
    
    func loadPokemon(completion: @escaping (PokemonModel?) -> Void) {
        self.interactor.fetchPokemon {
            completion($0)
        }
    }
    
    func pop(with type: PokemonTypes) {
        delegate?.pop(with: type)
        wireframe.pop()
    }
}
