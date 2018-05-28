//
//  ImagesViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ImagesViewController: ViewController {

    let imagesViewModel = ImagesViewModel()
    
    var session: Session? {
        get {
            return imagesViewModel.session
        }
        set {
            imagesViewModel.session = newValue
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imagesViewModel.loadData { result in
            print(result)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? ImageViewController)?.session = session
    }
    
}
