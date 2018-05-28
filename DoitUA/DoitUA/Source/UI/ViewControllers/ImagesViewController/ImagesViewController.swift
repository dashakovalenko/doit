//
//  ImagesViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ImagesViewController: ViewController {
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    
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
        
        imagesViewModel.loadData { [weak self] result in
            print(result)
            self?.imagesCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? ImageViewController)?.session = session
    }
    
}

extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesViewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(with: imagesViewModel.images[indexPath.row])
        
        return cell
    }
    
}

