//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/25.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var todayView: SCCalendarTodayView?
    @IBOutlet weak var monthView: SCCalendarMonthView?
    
    private var doOnce = false
    
    var viewForLayer = UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 300))
    var layer: CALayer {
        return viewForLayer.layer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initDataAndView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !doOnce {
            loadTodayViewAnimated()
            loadMonthViewAnimated()
        }
    }
    
    func initDataAndView() {
        let calendar = SCCalendar()
        self.todayView?.day = calendar.today()
        self.monthView?.days = calendar.thisMonth()
    }
    
    func loadTodayViewAnimated() {
        todayView?.transform = CGAffineTransform(translationX: 0.0, y: -((todayView?.bounds.height)! + (todayView?.frame.minY)!))
        UIView.animate(withDuration: 0.5, animations: {
            self.todayView?.transform = .identity
        }) { (finished) in
            
        }
    }
    
    func loadMonthViewAnimated() {
        monthView?.transform = CGAffineTransform(translationX: 0.0, y: ((monthView?.bounds.height)! + 5.0))
        UIView.animate(withDuration: 0.5, animations: {
            self.monthView?.transform = .identity
        }) { (finished) in
            
        }
    }
}

