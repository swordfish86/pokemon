//
//  DetailModule.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import UIKit

class DetailModule {
    private var presenter: DetailPresenterProtocol
    private weak var delegate: MainFlowProtocol?
    
    init(pokemonId: Int, delegate: MainFlowProtocol?) {
        
        let interactor = DetailInteractor(pokemonId: pokemonId)
        let wireframe = DetailWireframe()
        presenter = DetailPresenter(interactor: interactor,
                                    wireframe: wireframe)
        presenter.delegate = delegate
    }
}

extension DetailModule: DetailModuleProtocol {
    func present(navController: UINavigationController) {
        presenter.present(navController: navController)
    }
}
