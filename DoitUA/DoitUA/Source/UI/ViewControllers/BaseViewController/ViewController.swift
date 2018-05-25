//
//  ViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainView: View? {
        return isViewLoaded ? view as? View : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (mainView as? ScrollableView)?.subscribeToKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (mainView as? ScrollableView)?.unsubscribeFromKeyboardEvents()
    }

}
