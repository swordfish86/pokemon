//
//  LoginModule.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import UIKit

class MainModule {
    private var presenter: MainPresenterProtocol
    
    init() {
        let interactor = MainInteractor()
        let wireframe = MainWireframe()
        presenter = MainPresenter(interactor: interactor,
                                  wireframe: wireframe)
    }
}

extension MainModule: MainModuleProtocol {
    var rootController: UIViewController {
        presenter.rootController
    }    
}
