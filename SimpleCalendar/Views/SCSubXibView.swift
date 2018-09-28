//
//  SCSubXibView.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/27.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCSubXibView: UIView {
    @IBOutlet weak var contentView: UIView?
    
    public func loadXibName(name: String) {
        contentView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView
        addSubview(contentView!)
        let left = NSLayoutConstraint(item: contentView!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint(item: contentView!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: contentView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([top, left, bottom, right])
    }

}
