//
//  SCMonthDetailViewController.swift
//  简单历
//
//  Created by ZHXW on 2018/9/29.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class SCMonthDetailViewController: UIViewController, SCCalendarMonthViewDelegate {
    
    private var _days = [SCCalendarDay]()
    public var days: [SCCalendarDay] {
        set {
            _days = newValue
        }
        get {
            return _days
        }
    }
    
    private weak var _manager: SCCalendar?
    public var manager: SCCalendar? {
        set {
            _manager = newValue
        }
        get {
            return _manager
        }
    }
    
    @IBOutlet weak var monthView: SCCalendarMonthView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        monthView?.delegate = self
        monthView?.days = days
    }

    func monthView(_ monthView: SCCalendarMonthView, didSelectedDay day: Int, year: Int, month: Int) {
        let event = manager?.getEvent(year: year, month: month, day: day)
        print(event as Any)
    }
}
