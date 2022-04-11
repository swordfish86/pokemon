//
//  DetailWireframe.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import Foundation
import UIKit


class DetailWireframe {
    private var navBar: UINavigationController?
}

extension DetailWireframe: DetailWireframeProtocol {
    func pop() {
        navBar?.popViewController(animated: true)
    }
    
    func present(presenter: DetailPresenterProtocol,
                 navController: UINavigationController) {
        self.navBar = navController
        let viewController = DetailViewController(presenter: presenter)
        navController.pushViewController(viewController, animated: true)
    }
}
