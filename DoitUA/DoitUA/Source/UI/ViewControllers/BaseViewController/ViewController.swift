//
//  ViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NibLoaded {

    var mainView: View? {
        return isViewLoaded ? view as? View : nil
    }
    
    var loading: Bool = false {
        didSet {
            updateActivity()
        }
    }
    private var activityView: UIView?
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (mainView as? ScrollableView)?.subscribeToKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (mainView as? ScrollableView)?.unsubscribeFromKeyboardEvents()
    }
    
    //MARK: - Actions
    
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

    //MARK: - Public

    func showFailure(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    func showError(_ error: Error?) {
        guard let error = error else {
            return
        }
        
        showFailure(error.localizedDescription)
    }
    
    //MARK: - Private
    
    private func updateActivity() {
        if self.loading {
            if activityView != nil { return }
            let activity = ActivityView(frame: CGRect(origin: CGPoint.zero, size: view.frame.size))
            view.addSubview(activity)
            activityView = activity
        } else {
            activityView?.removeFromSuperview()
            activityView = nil
        }
    }

}
