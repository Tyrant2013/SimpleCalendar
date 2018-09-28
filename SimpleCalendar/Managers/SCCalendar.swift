//
//  SCCalendar.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/25.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit
import EventKit

class SCCalendar: NSObject {
    private let Zodiacs = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    private let HeavenlyStems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    private let EarthlyBranches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    private let weekDays = ["日", "一", "二", "三", "四", "五", "六"]
    private let ChineseMonths = ["正月", "杏月", "桃月", "梅月", "榴月", "荷月", "兰月", "桂月", "菊月", "良月", "幸月", "腊月"]
    private let ChineseDays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
    
    public func today() -> SCCalendarDay {
        let date = Date()
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        let day = calendar?.component(.day, from: date)
        let month = calendar?.component(.month, from: date)
        let year = calendar?.component(.year, from: date)
        let chineseDay = getChineseDayWithDate(date: date)
        let chineseShortDay = getChineseShortDayWithDate(date: date)
        let today = SCCalendarDay(day: day!,
                                  color: UIColor.black,
                                  font: UIFont.systemFont(ofSize: 90.0),
                                  forMonth: month!,
                                  forYear: year!,
                                  weekdayStr: getSystemLanguageStyleWeekdayString(weekday: (calendar?.component(.weekday, from: date))! - 1),
                                  chineseDay: chineseDay,
                                  dayStr: String(day!),
                                  monthStr: getSystemLanguageStyleMonthString(month: month!),
                                  yearStr: getSystemLanguageStyleYearString(year: year!),
                                  chineseShortDay: chineseShortDay,
                                  isToday: true)
        let startDate = Date()
        let endDate = Date(timeIntervalSinceNow: 60*24*30)
        getEvent(start: startDate, end: endDate)
        
        return today
    }
    
    public func thisMonth() -> [SCCalendarDay] {
        let date = Date()
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        let year = calendar?.component(.year, from: date)
        let month = calendar?.component(.month, from: date)
        return daysWithYear(year: year!, month: month!)
    }
    
    public func daysWithYear(year: Int, month: Int) -> [SCCalendarDay] {
        let calendar = Calendar(identifier: .gregorian)
        var dateComp = DateComponents()
        dateComp.year = year
        dateComp.month = month
        let date = calendar.date(from: dateComp)!
        let range = calendar.range(of: .day, in: .month, for: date)
        let week = calendar.component(.weekday, from: date)
        
        var dayTuple = [(day: Int, color: UIColor, month: Int, year: Int)]()
        let lastEnd = week - 1
        if lastEnd > 0 {
            var preYear = year
            var preMonth = month - 1
            if month == 1 {
                preMonth = 12
                preYear -= 1
            }
            dateComp.year = preYear
            dateComp.month = preMonth
            let preDate = calendar.date(from: dateComp)!
            let preRange = calendar.range(of: .day, in: .month, for: preDate)!
            
            for i in 1...lastEnd {
                let day = preRange.count - lastEnd + i
                dayTuple.append((day, UIColor.lightGray, preMonth, preYear))
            }
        }
        for i in range! {
            dayTuple.append((i, UIColor.black, month, year))
        }
        if dayTuple.count < 42 {
            var lastYear = year
            var lastMonth = month + 1
            if month == 12 {
                lastYear += 1
                lastMonth = 1
            }
            let endCount = 42 - dayTuple.count
            for i in 1...endCount {
                dayTuple.append((i, UIColor.lightGray, lastMonth, lastYear))
            }
        }

        let todayDate = Date()
        
        return dayTuple.map { (day, color, month, year) -> SCCalendarDay in
            dateComp.year = year
            dateComp.month = month
            dateComp.day = day
            let date = calendar.date(from: dateComp)!
            let isToday = calendar.component(.year, from: todayDate) == year && calendar.component(.month, from: todayDate) == month && calendar.component(.day, from: todayDate) == day
            let chineseDay = getChineseDayWithDate(date: date)
            let chineseShortDate = getChineseShortDayWithDate(date: date)
            return SCCalendarDay(day: day,
                                 color: color,
                                 font: UIFont.systemFont(ofSize: 15.0),
                                 forMonth: month,
                                 forYear: year,
                                 weekdayStr: getSystemLanguageStyleWeekdayString(weekday: day),
                                 chineseDay: chineseDay,
                                 dayStr: String(day),
                                 monthStr: getSystemLanguageStyleMonthString(month: month),
                                 yearStr: getSystemLanguageStyleYearString(year: year),
                                 chineseShortDay: chineseShortDate,
                                 isToday: isToday)
        }
    }
    
    private func getSystemLanguageStyleYearString(year: Int) -> String {
        return String(year) + "年"
    }
    
    private func getSystemLanguageStyleMonthString(month: Int) -> String {
        return String(month) + "月"
    }
    
    private func getSystemLanguageStyleWeekdayString(weekday: Int) -> String {
        return "星期" + weekDays[weekday % 7]
    }
    
    private func getEvent(start: Date, end: Date) {
        let store = EKEventStore()
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                let fetchCalendarEvents = store.predicateForEvents(withStart: start, end: end, calendars: nil)
                let eventList = store.events(matching: fetchCalendarEvents)
                let events = eventList.filter({ (event) -> Bool in
                    return event.calendar.isSubscribed
                })
                for item in events {
                    print(item)
                }
            }
        }
    }
    
    private func getChineseDayWithDate(date: Date) -> String {
        let calendar = Calendar(identifier: .chinese)
        let year = calendar.component(.year, from: date)
        let heavenlyStemIndex = (year - 1) % HeavenlyStems.count
        let earthlyBranchesIndex = (year - 1) % EarthlyBranches.count
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        return HeavenlyStems[heavenlyStemIndex] + EarthlyBranches[earthlyBranchesIndex] + "年 " + ChineseMonths[month - 1] + ChineseDays[(day - 1) % 7]
    }
    private func getChineseShortDayWithDate(date: Date) -> String {
        let calendar = Calendar(identifier: .chinese)
        let day = calendar.component(.day, from: date)
        return ChineseDays[(day - 1) % 7]
    }
    
    // MARK: 测试
    public func test() -> Void {
        self.testGregorianDate()
        self.testChineseDate()
        self.testCurrentZodiacs()
        self.testCurrentHeavenlyStemsAndEarthlyBranches()
    }
    public func testGregorianDate() -> Void {
        print("Print The Gregorian Date: ")
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        print("Year: ", calendar.component(.year, from: date), "Month: ", calendar.component(.month, from: date), "Day: ", calendar.component(.day, from: date))
    }
    public func testChineseDate() -> Void {
        print("打印农历日期：")
        let date = Date()
        let calendar = Calendar(identifier: .chinese)
        print("年: ", calendar.component(.year, from: date), "月: ", calendar.component(.month, from: date), "日: ", calendar.component(.day, from: date))
    }
    public func testCurrentZodiacs() -> Void {
        print("打印当前年份的生肖：")
        let date = Date()
        let calendar = Calendar(identifier: .chinese)
        let year = calendar.component(.year, from: date)
        let zodiacIndex = (year - 1) % Zodiacs.count
        print("年：", year, " 生肖：", Zodiacs[zodiacIndex])
    }
    public func testCurrentHeavenlyStemsAndEarthlyBranches() -> Void {
        print("打印天干地支：")
        let date = Date()
        let calendar = Calendar(identifier: .chinese)
        let year = calendar.component(.year, from: date)
        let heavenlyStemIndex = (year - 1) % HeavenlyStems.count
        let earthlyBranchesIndex = (year - 1) % EarthlyBranches.count
        print("天干：", HeavenlyStems[heavenlyStemIndex], "地支：", EarthlyBranches[earthlyBranchesIndex])
    }
}
