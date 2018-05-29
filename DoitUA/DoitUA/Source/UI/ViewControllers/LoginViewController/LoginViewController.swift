//
//  LoginViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class LoginViewController: ViewController, SessionFetcher {
    
    private let loginModel = LoginViewModel()
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    //MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - Actions
    
    @IBAction func didChangeEmail(_ sender: UITextField) {
        loginModel.email = sender.text
    }
    
    @IBAction func didChangePassword(_ sender: UITextField) {
        loginModel.password = sender.text
    }
    
    @IBAction func didClickOnSend(_ sender: Any) {
        fetchSession(call: loginModel.loadData)
    }
}
