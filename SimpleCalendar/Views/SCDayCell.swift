//
//  SCDayCell.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/26.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCDayCell: UICollectionViewCell {
    
    @IBOutlet weak var numLabel: UILabel?
    @IBOutlet weak var secLabel: UILabel?
    @IBOutlet weak var simpleLabel: UILabel?
    
    let testSimpleShow = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        simpleLabel?.isHidden = true
        secLabel?.isHidden = true
        numLabel?.isHidden = true
        
        secLabel?.textColor = UIColor.rgb(r: 121, g: 121, b: 121)
        layer.borderColor = UIColor.rgb(r: 212, g: 212, b: 212).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 25.0
    }
    
    public func setData(day: SCCalendarDay) {
        numLabel?.text = day.dayStr
        numLabel?.textColor = day.color
        
        secLabel?.text = day.chineseShortDay
        
        simpleLabel?.text = day.dayStr
        simpleLabel?.textColor = day.color
        
        simpleLabel?.isHidden = testSimpleShow
        numLabel?.isHidden = !testSimpleShow
        secLabel?.isHidden = !testSimpleShow
        
        if day.isToday {
            layer.backgroundColor = UIColor.rgb(r: 221, g: 84, b: 46).cgColor
            numLabel?.textColor = UIColor.white
            secLabel?.textColor = UIColor.white
        }
        else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }
}
