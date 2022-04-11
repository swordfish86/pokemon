//
//  PockemonCell.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 10/04/22.
//

import Foundation
import UIKit

final class PokemonCell: UICollectionViewCell {
    static let identifier = "PokemonCell"
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var pokemonImageView: UIImageView!
    private var imageDownloader = ImageDownloader()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        pokemonNameLabel.text = ""
        imageDownloader.cancel()
        imageDownloader = ImageDownloader()
    }
    
    func update(name: String, urlImage: URL?) {
        pokemonNameLabel.text = name
        if let url = urlImage {
            imageDownloader.download(url: url) { [weak self] image , error in
                if let image = image {
                    self?.pokemonImageView.image = image
                }
            }
        }
    }
}
