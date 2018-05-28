//
//  MainScreenPresenter.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol MainScreenPresenter {
}

extension MainScreenPresenter where Self: UIViewController {
    
    func showMainImagesScreen(_ session: Session) {
        let identifier = NSStringFromClass(ImagesViewController.self).components(separatedBy: ".").last ?? ""
        guard let imagesViewController = UIStoryboard(name: identifier, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? ImagesViewController else {
            fatalError()
        }
        
        imagesViewController.session = session
        let navigationController = UINavigationController(rootViewController: imagesViewController)
        navigationController.navigationBar.backgroundColor = UIColor.darkGray
        navigationController.navigationBar.tintColor = UIColor.white
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
}
