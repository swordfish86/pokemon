//
//  DetailDatasource.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import Foundation
import UIKit

final class DetailDatasource: NSObject {
    private var presenter: DetailPresenterProtocol
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
    }
}

extension DetailDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.pokemonData?.stats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.reuse()
        let stat = presenter.pokemonData?.stats[indexPath.row]
        cell.update(name: stat?.stat?.name ?? "", value: stat?.baseStat ?? 0)
        return cell
    }
}
