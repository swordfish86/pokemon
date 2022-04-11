//
//  MainDatasource.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 10/04/22.
//

import UIKit

final class MainDatasource: NSObject {
    private var presenter: MainPresenterProtocol
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MainDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PokemonCell = collectionView.reuse(at: indexPath)
        if let pokemon = presenter.data[indexPath.row] as? Pokemon {
            cell.update(name: pokemon.name, urlImage: pokemon.urlImage)
        } else if let pokemon = presenter.data[indexPath.row] as? PokemonModel {
            cell.update(name: pokemon.name, urlImage: pokemon.frontUrlImage)
        } else if let pokemon = presenter.data[indexPath.row] as? PokemonInfo {
            cell.update(name: pokemon.pokemon?.name ?? "",
                        urlImage: pokemon.pokemon?.urlImage)
        }
        return cell
    }
}
