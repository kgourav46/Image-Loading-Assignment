//
//  UICollectionView+Extension.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}
