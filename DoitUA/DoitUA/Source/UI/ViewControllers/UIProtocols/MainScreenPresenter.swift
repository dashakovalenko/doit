//
//  MainScreenPresenter.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol RootPresenter {}
protocol MainScreenPresenter: RootPresenter {}
protocol LoginPresenter: RootPresenter {}

extension RootPresenter {
    
    fileprivate func setAsRoot(_ viewController: UIViewController?) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}

extension MainScreenPresenter {
    
    func showMainImagesScreen(_ session: Session) {
        let identifier = ImagesViewController.nibName
        guard let imagesViewController = UIStoryboard(name: identifier, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? ImagesViewController else {
            fatalError()
        }
        
        imagesViewController.session = session
        let navigationController = UINavigationController(rootViewController: imagesViewController)
        navigationController.navigationBar.backgroundColor = UIColor.darkGray
        navigationController.navigationBar.tintColor = UIColor.white
        setAsRoot(navigationController)
    }
    
}

extension LoginPresenter {
    
    func showLoginScreen() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        setAsRoot(loginController)
    }
}
