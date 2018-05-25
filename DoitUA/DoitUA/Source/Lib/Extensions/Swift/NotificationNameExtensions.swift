//
//  NotificationNameExtensions.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static var keyboardNotifications: [Notification.Name] {
        return [.UIKeyboardWillShow, .UIKeyboardWillChangeFrame, .UIKeyboardWillHide]
    }
    
}
