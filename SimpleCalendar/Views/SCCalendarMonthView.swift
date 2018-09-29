//
//  SCCalendarMonthView.swift
//  SimpleCalendar
//
//  Created by ZHXW on 2018/9/26.
//  Copyright © 2018年 Freedom. All rights reserved.
//

import UIKit

protocol SCCalendarMonthViewDelegate {
    func monthView(_ monthView: SCCalendarMonthView, didSelectedDay day: Int, year: Int, month: Int);
}

class SCCalendarMonthView: SCSubXibView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let headerCell = "HeaderCell"
    private let itemCell = "ItemCell"
    private let weekDayDescs = ["日", "一", "二", "三", "四", "五", "六"]
    
    @IBOutlet weak var headerCollectionView: UICollectionView?
    @IBOutlet weak var itemCollectionView: UICollectionView?
    
    private var _days = [SCCalendarDay]()
    var days: [SCCalendarDay] {
        get {
            return _days
        }
        set(newVal) {
            _days = newVal
            itemCollectionView?.reloadData()
        }
    }
    public var delegate: SCCalendarMonthViewDelegate?
    
    private func loadXib() {
        loadXibName(name: "SCCalendarMonthView")
        
        contentView?.backgroundColor = UIColor.rgb(r: 230, g: 255, b: 253)
        headerCollectionView?.backgroundColor = UIColor.rgb(r: 0, g: 49, b: 41)
        contentView?.layer.cornerRadius = 10.0
        contentView?.backgroundColor = UIColor.clear
        
        let headerNib = UINib(nibName: "SCWeekdayDescCell", bundle: nil)
        headerCollectionView?.register(headerNib, forCellWithReuseIdentifier: headerCell)
        
        let itemNib = UINib(nibName: "SCDayCell", bundle: nil)
        itemCollectionView?.register(itemNib, forCellWithReuseIdentifier: itemCell)
        itemCollectionView?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let width = CGFloat(Int(ceil(UIScreen.main.bounds.width / 7) / 10) * 10)
//        let sectionSpace = (UIScreen.main.bounds.width - width * 7) / 2
//        let sectionInset = UIEdgeInsets(top: 0, left: sectionSpace, bottom: 0, right: sectionSpace)
//
//        let headerLayout = headerCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        var itemSize = headerLayout.itemSize
//        itemSize.width = width
//        headerLayout.itemSize = itemSize
//        headerLayout.minimumInteritemSpacing = 0
//        headerLayout.sectionInset = sectionInset
//        headerCollectionView?.collectionViewLayout = headerLayout
//
//        let itemLayout = itemCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        itemSize = itemLayout.itemSize
//        itemSize.width = width
//        itemLayout.itemSize = itemSize
//        itemLayout.minimumInteritemSpacing = 0
//        itemLayout.sectionInset = sectionInset
//        itemCollectionView?.collectionViewLayout = itemLayout
        
//        print("width: ", UIScreen.main.bounds.width / 7,  "header size: ", headerLayout.itemSize, "item size: ", itemLayout.itemSize)
    }
    
    override func awakeFromNib() {
        loadXib()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return 7
        }
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCell, for: indexPath) as! SCWeekdayDescCell
            cell.nameLabel?.text = weekDayDescs[indexPath.row]
            cell.nameLabel?.textColor = UIColor.white
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! SCDayCell
        if indexPath.row < days.count {
            let day = days[indexPath.row]
            cell.setData(day: day)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        if let del = delegate {
            del.monthView(self, didSelectedDay: day.day, year: day.forYear, month: day.forMonth)
        }
    }
}
