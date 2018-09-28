//
//  SCMonthCell.swift
//  简单历
//
//  Created by ZHXW on 2018/9/28.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCMonthCell: UICollectionViewCell {
    
    @IBOutlet weak var monthView: SCCalendarMonthView?
    @IBOutlet weak var monthLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        monthLabel?.textColor = UIColor.rgb(r: 212, g: 212, b: 212)
        monthLabel?.font = UIFont(name: "Courier New", size: 200)
    }
    
    func setupDatas(_ datas: [SCCalendarDay], month: Int) {
        monthView?.days = datas
        monthLabel?.text = String(month)
    }
}
