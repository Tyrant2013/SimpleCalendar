//
//  SCCalendarDay.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/25.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

struct SCCalendarDay {
    var day: Int
    var forMonth: Int
    var forYear: Int
    var dayStr: String
    var monthStr: String
    var yearStr: String
    var color: UIColor
    var font: UIFont
    var weekdayStr: String
    var chineseDay: String
    var chineseShortDay: String
    var envet: String?
    var isToday: Bool
    
    init(day: Int,
         color: UIColor,
         font: UIFont,
         forMonth: Int,
         forYear: Int,
         weekdayStr: String,
         chineseDay: String,
         dayStr: String,
         monthStr: String,
         yearStr: String,
         chineseShortDay: String,
         isToday: Bool) {
        self.day = day
        self.font = font
        self.color = color
        self.forMonth = forMonth
        self.forYear = forYear
        self.weekdayStr = weekdayStr
        self.chineseDay = chineseDay
        self.dayStr = dayStr
        self.monthStr = monthStr
        self.yearStr = yearStr
        self.chineseShortDay = chineseShortDay
        self.isToday = isToday
    }
}
