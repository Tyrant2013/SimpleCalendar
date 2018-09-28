//
//  UIColorExtern.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/26.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func rgb(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
