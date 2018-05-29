//
//  SessionFetcher.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol SessionFetcher: RootPresenter {}

extension SessionFetcher where Self: ViewController {
    
    func fetchSession(call:(((Result<Session>) -> ())?) -> Void) {
        loading = true
        call { [weak self] result in
            self?.loading = false
            switch result {
            case .success(let response):
                self?.showMainImagesScreen(response)
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
    
    private func showMainImagesScreen(_ session: Session) {
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
