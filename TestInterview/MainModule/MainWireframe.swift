//
//  LoginWireframe.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import UIKit

class MainWireframe: MainWireframeProtocol {
    
    private weak var viewController: MainViewController?
    lazy var rootController = UINavigationController()
    
    init() {}
    
    func buildController(presenter: MainPresenterProtocol) {
        let vc = MainViewController(presenter: presenter)
        rootController.pushViewController(vc, animated: true)
        viewController = vc
    }
    
    func reloadData(type: PokemonTypes) {
        viewController?.reloadData(type: type)
    }

    func showDetail(pokemonData: PokemonData, delegate: MainFlowProtocol) {
        var pokemonId: Int = 0
        if let pokemon = pokemonData as? Pokemon {
            pokemonId = pokemon.pokemonId
        } else if let pokemon = pokemonData as? PokemonModel {
            pokemonId = pokemon.id
        } else if let pokemon = pokemonData as? PokemonInfo {
            pokemonId = pokemon.pokemon?.pokemonId ?? 0
        }
        let detailModule = DetailModule(pokemonId: pokemonId,
                                        delegate: delegate)
        detailModule.present(navController: rootController)
    }
}
