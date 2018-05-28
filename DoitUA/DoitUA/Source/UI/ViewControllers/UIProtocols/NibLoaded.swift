//
//  NibLoaded.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol NibLoaded: class {
    static var nibName: String { get }
}

extension NibLoaded where Self: UIViewController {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
