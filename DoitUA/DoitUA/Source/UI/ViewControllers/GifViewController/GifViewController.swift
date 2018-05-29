//
//  GifViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GifViewController: ViewController {

    @IBOutlet var gifImageView: UIImageView!
    
    let gifViewModel = GifViewModel()
    var session: Session? {
        get {
            return gifViewModel.session
        }
        set {
            gifViewModel.session = newValue
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - Actions
    
    @IBAction func onDismiss(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension GifViewController: DataLoader {
    typealias Model = UIImage?

    var dataLoadCall: (((Result<UIImage?>) -> ())?) -> Void {
        return gifViewModel.loadData
    }
    
    func handleSuccess(_ data: UIImage?) {
        gifImageView.image = data
    }
}
