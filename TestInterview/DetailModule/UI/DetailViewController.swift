//
//  DetailViewController.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var normlImageView: UIImageView!
    @IBOutlet private weak var shinyImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var statsTableView: UITableView!
    @IBOutlet private weak var typeButton: UIButton! {
        didSet {
            typeButton.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet private weak var typeTagView: UIView! {
        didSet {
            typeTagView.layer.cornerRadius = typeTagView.frame.size.height / 2
            typeTagView.layer.shadowColor = UIColor.black.cgColor
            typeTagView.layer.shadowOpacity = 1
            typeTagView.layer.shadowOffset = .zero
            typeTagView.layer.shadowRadius = 10
        }
    }
    
    private var presenter: DetailPresenterProtocol
    private var dataSource: DetailDatasource?
    private var normalImageDownloader = ImageDownloader()
    private var shinyImageDownloader = ImageDownloader()
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        let nibName = String(describing: DetailViewController.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        dataSource = DetailDatasource(presenter: presenter)
        statsTableView.dataSource = dataSource
        typeButton.isEnabled = false
        
        presenter.loadPokemon { [weak self] in
            guard let self = self else { return }
            self.nameLabel.text = $0?.name ?? ""
            self.numberLabel.text = String($0?.id ?? 0)
            self.updateImages(front: $0?.frontUrlImage,
                              shiny: $0?.shinyUrlImage)
            self.statsTableView.reloadData()
            guard let type = $0?.firstType else {
                self.typeTagView.isHidden = true
                return
            }
            self.typeButton.isEnabled = true
            self.typeTagView.backgroundColor = type.color
            self.typeButton.setTitle(type.rawValue, for: .normal)
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: DetailCell.identifier, bundle: nil)
        statsTableView.register(nib, forCellReuseIdentifier: DetailCell.identifier)
    }
    
    @IBAction private func typeSelected(_ sender: UIButton) {
        guard let type = presenter.pokemonData?.firstType else {
            return
        }
        presenter.pop(with: type)
    }
    
    private func updateImages(front: URL?, shiny: URL?) {
        if let url = front {
            normalImageDownloader.download(url: url) { [weak self] image , error in
                if let image = image {
                    self?.normlImageView.image = image
                }
            }
        }
        
        if let url = shiny {
            shinyImageDownloader.download(url: url) { [weak self] image , error in
                if let image = image {
                    self?.shinyImageView.image = image
                }
            }
        }
    }
}
