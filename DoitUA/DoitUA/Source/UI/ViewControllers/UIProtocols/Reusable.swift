//
//  NibLoaded.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}

extension UICollectionViewCell: Reusable {}

//MARK: - UICollectionView

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
