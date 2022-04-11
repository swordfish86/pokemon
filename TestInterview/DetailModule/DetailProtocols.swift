//
//  DetailProtocols.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import Foundation

import UIKit

protocol DetailPresenterProtocol {
    var pokemonData: PokemonModel? { get }
    var delegate: MainFlowProtocol? { get set }
    
    func loadPokemon(completion: @escaping (PokemonModel?) -> Void)
    func present(navController: UINavigationController)
    func pop(with type: PokemonTypes)
}

protocol DetailWireframeProtocol {
    func pop()
    func present(presenter: DetailPresenterProtocol, navController: UINavigationController)
}
protocol DetailInteractorProtocol {
    var pokemonData: PokemonModel? { get }
    
    func fetchPokemon(completion: @escaping (PokemonModel?) -> Void)
}

protocol DetailModuleProtocol {
    func present(navController: UINavigationController)
}
