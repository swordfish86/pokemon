//
//  LoginProtocols.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import UIKit

protocol MainPresenterProtocol {
    var data: [PokemonData] { get }
    var rootController: UIViewController { get }
    
    func loadPokemons(search: String, completion: @escaping () -> Void)
    func showDetail(pokemonData: PokemonData)
}

extension MainPresenterProtocol {
    func loadPokemons(search: String = "", completion: @escaping () -> Void) {
        loadPokemons(search: search, completion: completion)
    }
}

protocol MainWireframeProtocol {
    var rootController: UINavigationController { get }
    
    func reloadData(type: PokemonTypes) 
    func showDetail(pokemonData: PokemonData, delegate: MainFlowProtocol)
    func buildController(presenter: MainPresenterProtocol)
}
protocol MainInteractorProtocol {
    var data: [PokemonData] { get }
    
    func fetchPokemon(by nameId: String, completion: @escaping ([PokemonData]) -> Void)
    func fetchPokemon(type: PokemonTypes, completion: @escaping ([PokemonData]) -> Void)
}

protocol MainModuleProtocol {
    var rootController: UIViewController { get }
}

protocol MainFlowProtocol: NSObject {
    func pop(with type: PokemonTypes)
}
