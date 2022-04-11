//
//  CollectionView+Extension.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 10/04/22.
//

import UIKit

public extension UICollectionView {
    func reuse<T: UICollectionViewCell>(at index: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? T else {
            return T()
        }
        return cell
    }
}
