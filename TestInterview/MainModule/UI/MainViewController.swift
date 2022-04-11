//
//  LoginViewController.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var titleScreen: UILabel!
    @IBOutlet private weak var searchView: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var presenter: MainPresenterProtocol
    private var dataSource: MainDatasource?
 
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        let nibName = String(describing: MainViewController.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        registerCells()
        dataSource = MainDatasource(presenter: presenter)
        titleScreen.text = LanguageString.titleMainScreen.localized
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        presenter.loadPokemons { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: PokemonCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PokemonCell.identifier)

    }
    
    func reloadData(type: PokemonTypes) {
        searchView.text = type.rawValue
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if presenter.data.count > 2 &&
            indexPath.row == (presenter.data.count - 1) {
            presenter.loadPokemons { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(pokemonData: presenter.data[indexPath.row])
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        presenter.loadPokemons(search: searchText) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        var searchText = searchBar.text ?? ""
        searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        presenter.loadPokemons(search: searchText) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
