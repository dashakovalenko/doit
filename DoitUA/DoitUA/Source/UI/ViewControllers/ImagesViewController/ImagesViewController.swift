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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imagesViewController = segue.destination as? ImageViewController {
            imagesViewController.session = session
            imagesViewController.newImageHandler = loadData
        }
        if let gifViewController = segue.destination as? GifViewController {
            gifViewController.session = session
        }
    }
    
    //MARK: - Actions
    
    @IBAction func didClickOnLogout(_ sender: Any) {
        showLoginScreen()
    }
    
    //MARK: - Private
    
    private func loadData() {
        imagesViewModel.loadData { [weak self] result in
            self?.imagesCollectionView.reloadData()
        }
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

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let numberOfItems: CGFloat = CGFloat(numberOfItemsInRow)
        let cellWidth = (collectionView.frame.size.width - (10 * (numberOfItems + 1))) / numberOfItems
        
        return CGSize(width: cellWidth, height: cellWidth * 1.09)
    }
    
    private var numberOfItemsInRow: Int {
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            return 3
        default:
            return 2
        }
    }
}

