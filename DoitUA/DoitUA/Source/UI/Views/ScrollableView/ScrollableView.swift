//
//  ScrollableView.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ScrollableView: View {

    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet var fieldsContainerView: UIView!
    
    //MARK: - Public
    
    func subscribeToKeyboardEvents() {
        let notificationCenter = NotificationCenter.default
        Notification.Name.keyboardNotifications.forEach {
            notificationCenter.addObserver(self,  selector:#selector(didUpdateKeyboard(_:)), name: $0, object: nil)
        }
    }
    
    func unsubscribeFromKeyboardEvents() {
        let notificationCenter = NotificationCenter.default
        Notification.Name.keyboardNotifications.forEach {
            notificationCenter.removeObserver(self, name: $0, object: nil)
        }
    }
    
    //MARK: - Private
    
    @objc private func didUpdateKeyboard(_ notificaiton: Notification) {
        let userInfo = notificaiton.userInfo
        let showKeyboard = notificaiton.name != .UIKeyboardWillHide
        let keyboardFrame: CGRect? = showKeyboard ? (userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect) : nil
        let keyboardHeight = keyboardFrame?.size.height ?? 0
        contentScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        contentScrollView.contentOffset = showKeyboard ? fieldsContainerView.frame.origin : CGPoint.zero
    }

}
