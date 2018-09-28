//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/25.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var todayView: SCCalendarTodayView?
    @IBOutlet weak var collectionView: UICollectionView?
    
    private var doOnce = false
    private let manager = SCViewControllerManager()
    private let ItemCell = "ItemCell"
    private var checkIndex = 0
    
    private var startDrag: CGFloat = 0
    private var endDrag: CGFloat = 0
    private var currentIndex = 0
    
    var viewForLayer = UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 300))
    var layer: CALayer {
        return viewForLayer.layer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initDataAndView()
        initGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !doOnce {
            loadTodayViewAnimated()
            loadMonthViewAnimated()
        }
    }
    
    func initGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapRecognizer(sender:)))
        self.todayView?.addGestureRecognizer(tap)
    }
    
    @objc func tapRecognizer(sender: UITapGestureRecognizer) {
        let month = (todayView?.day?.forMonth)!
        collectionView?.scrollToItem(at: IndexPath(item: (month - 1), section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func initDataAndView() {
        let calendar = SCCalendar()
        self.todayView?.day = calendar.today()
        
        let nib = UINib(nibName: "SCMonthCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: ItemCell)
        
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        var itemSize = layout.itemSize
        let sectionInset = layout.sectionInset
        itemSize.width = collectionView!.bounds.width - sectionInset.left - sectionInset.right
        itemSize.height = collectionView!.bounds.height - sectionInset.top - sectionInset.bottom
        layout.itemSize = itemSize
        
        collectionView?.reloadData()
        collectionView?.scrollToItem(at: IndexPath(item: (manager.curMonth - 1), section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func loadTodayViewAnimated() {
        todayView?.transform = CGAffineTransform(translationX: 0.0, y: -((todayView?.bounds.height)! + (todayView?.frame.minY)!))
        UIView.animate(withDuration: 0.5, animations: {
            self.todayView?.transform = .identity
        }) { (finished) in
            
        }
    }
    
    func loadMonthViewAnimated() {
        collectionView?.transform = CGAffineTransform(translationX: 0.0, y: ((collectionView?.bounds.height)! + 5.0))
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView?.transform = .identity
        }) { (finished) in
            
        }
    }
    
    // MARK: -- UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.monthDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let days = manager.monthDays[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell, for: indexPath) as! SCMonthCell
        cell.setupDatas(days, month: indexPath.row + 1)
        return cell
    }
}

