//
//  ActivityView.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    private lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        let activityFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        let activity = UIActivityIndicatorView(frame: activityFrame)
        activity.activityIndicatorViewStyle = .whiteLarge
        activity.center = self.center
        activity.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleBottomMargin]
        self.addSubview(activity)
        
        return activity
    }()
    
    //MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    //MARK: - Private
    
    private func setup() {
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        activityIndicator.startAnimating()
    }

}
