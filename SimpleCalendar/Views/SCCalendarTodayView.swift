//
//  CSCalendarTodayView.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/26.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCCalendarTodayView: SCSubXibView {
    
    @IBOutlet var yearLabel: UILabel?
    @IBOutlet var monthLabel: UILabel?
    @IBOutlet var dayLabel: UILabel?
    @IBOutlet var chineseDayLabel: UILabel?
    @IBOutlet var weekDayLabel: UILabel?
    
    private var _day: SCCalendarDay?
    var day: SCCalendarDay? {
        set(newValue) {
            _day = newValue
            if let dd = _day {
                yearLabel?.text = dd.yearStr
                monthLabel?.text = dd.monthStr
                dayLabel?.text = dd.dayStr
                chineseDayLabel?.text = dd.chineseDay
                weekDayLabel?.text = dd.weekdayStr
            }
        }
        get {
            return _day
        }
    }
    
    private func loadXibViewFromFile() {
        loadXibName(name: "SCCalendarTodayView")
        
        contentView?.backgroundColor = UIColor.rgb(r: 152, g: 180, b: 179)
        contentView?.layer.borderColor = UIColor.rgb(r: 188, g: 199, b: 199).cgColor
        contentView?.layer.cornerRadius = 10.0
        contentView?.layer.borderWidth = 1.0
    }

    init(day: SCCalendarDay, frame: CGRect) {
        super.init(frame: frame)
        loadXibViewFromFile()
        self.day = day
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        loadXibViewFromFile()
    }
}
