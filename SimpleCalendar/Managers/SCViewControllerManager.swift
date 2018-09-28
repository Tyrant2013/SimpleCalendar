//
//  SCViewControllerManager.swift
//  简单历
//
//  Created by ZHXW on 2018/9/28.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCViewControllerManager: NSObject {
    
    let calendarManager = SCCalendar()
    var monthDays = [[SCCalendarDay]]()
    var curPage = 0
    var minYear = 0
    var maxYear = 0
    
    let todayData: SCCalendarDay
    let curMonth: Int
    
    override init() {
        todayData = calendarManager.today()
        let date = Date()
        let calendar = NSCalendar(identifier: .gregorian)!
        let year = calendar.component(.year, from: date)
        curMonth = calendar.component(.month, from: date)
        minYear = year
        maxYear = year
        
        super.init()
        makeOneYearDatas(year: year)
    }
    
    private func makeOneYearDatas(year: Int) {
        for month in 1...12 {
            monthDays.append(calendarManager.daysWithYear(year: year, month: month))
        }
    }
    
    public func loadPrefixData(curRow: Int, completion: (_ index: Int) -> Void) {
        minYear -= 1
        for month in (1...12).reversed() {
            monthDays.insert(calendarManager.daysWithYear(year: minYear, month: month), at: 0)
        }
        completion(curRow + 12)
    }
    
    public func loadNextData(curRow: Int) {
        maxYear += 1
        makeOneYearDatas(year: maxYear)
    }
    
    public func checkNeedLoadPrefixDatas(curRow: Int) -> Bool {
        return curRow < 6
    }
    
    public func checkNeedLoadNextDatas(curRow: Int) -> Bool {
        return curRow + 6 > monthDays.count
    }

}
