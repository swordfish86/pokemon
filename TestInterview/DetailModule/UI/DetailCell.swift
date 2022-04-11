//
//  DetailCell.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 11/04/22.
//

import Foundation
import UIKit

final class DetailCell: UITableViewCell {
    static let identifier = "DetailCell"
    @IBOutlet private weak var statNameLabel: UILabel!
    @IBOutlet private weak var statValueLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        statNameLabel.text = ""
        statValueLabel.text = ""
    }
    
    func update(name: String, value: Int) {
        statNameLabel.text = name
        statValueLabel.text = String(value)
    }
}
