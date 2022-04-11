//
//  LoginPresenter.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//
import UIKit

class MainPresenter: NSObject {
    private var interactor: MainInteractorProtocol
    private var wireframe: MainWireframeProtocol
    private var searchTask: DispatchWorkItem?
    
    init(interactor: MainInteractorProtocol,
         wireframe: MainWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    var data: [PokemonData] {
        interactor.data
    }
    var rootController: UIViewController {
        wireframe.buildController(presenter: self)
        return wireframe.rootController
    }
    
    func loadPokemons(search: String, completion: @escaping () -> Void) {
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                if let type = PokemonTypes(rawValue: search) {
                    self.interactor.fetchPokemon(type: type) { pokemonData in
                        completion()
                    }
                } else {
                    self.interactor.fetchPokemon(by: search) { pokemonData in
                        completion()
                    }
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func showDetail(pokemonData: PokemonData) {
        wireframe.showDetail(pokemonData: pokemonData,
                             delegate: self)
    }
}

extension MainPresenter: MainFlowProtocol {
    func pop(with type: PokemonTypes) {
        interactor.fetchPokemon(type: type) {[weak self] pokemonsData in
            guard let self = self else { return }
            self.wireframe.reloadData(type: type)
        }
    }
}
