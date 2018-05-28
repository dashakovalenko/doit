//
//  File.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

extension UIImage {

    var oriented: UIImage? {
        if (self.imageOrientation == .up) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        self.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
}
