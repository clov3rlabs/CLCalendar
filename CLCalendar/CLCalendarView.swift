//
//  CLCalendarView.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/14/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import UIKit

class CLCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var startDate: NSDate! = NSDate()
    var endDate: NSDate! = NSDate().dateByAddingMonths(12).lastDayOfMonth()
    var calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    var showWeekNumber: Bool! = false
    var weekDayLbls: [String] = [ "S", "M", "T", "W", "T", "F", "S" ]   // It starts on Sunday
    var delegate: CLCalendarViewDelegate?
    var dates: [NSDate]! = []
    
    private var daySize : CGSize = CGSizeMake(0, 41)
    private var padding : CGFloat = 0
    private let weekDayHeight: CGFloat = 20
    private let weekNumberWidth: Float = 26

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize()
    {
        let cols : Int = 7
        daySize.width = floor(self.frame.width/CGFloat(cols))
        padding = (self.frame.width - (daySize.width*CGFloat(cols))) / 2
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        var collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.allowsMultipleSelection = true
        
        // Registering classes
        collectionView.registerClass(CLCalendarHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.registerClass(CLCalendarWeekDayCollectionViewCell.self, forCellWithReuseIdentifier: "WeekDayCell")
        collectionView.registerClass(CLCalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: "DayCell")
        
        self.addSubview(collectionView)
        let today: NSDate = NSDate()
        let sun: NSDate = today.dateByAddingDays(-4)
        var weekDayNumer: String = today.strftime("c")
        var weekDay: String = today.strftime("ccccccc")
        var sunWeekDayNumer: String = sun.strftime("c")
        var sunWeekDay: String = sun.strftime("ccccccc")
    }
    
    // MARK: Object Helpers
    
    private func dateForFirstDayOfSection(section: Int) -> NSDate {
        return (startDate?.firstDayOfMonth().dateByAddingMonths(section))!
    }
    
    private func offsetForSection(section: Int) -> Int {
        let firstDayOfMonth: NSDate = dateForFirstDayOfSection(section)
        return firstDayOfMonth.weekday() - 1
    }
    
    private func dateForIndexPath(indexPath: NSIndexPath ) -> NSDate {
        var date : NSDate! = startDate?.dateByAddingMonths(indexPath.section)
        let components : NSDateComponents = date.components()
        
        components.day = (indexPath.item - 7) + 1;
        date = NSDate.dateFromComponents(components)
    
        let offset: Int = offsetForSection(indexPath.section);
        if (offset != 0) {
            date = date.dateByAddingDays(-offset);
        }
    
        return date;
    }
    
    // This helps us to determine if the cell is a week day cell
    // (for label uses) or a day
    private func isWeekDay(indexPath: NSIndexPath) -> Bool
    {
        return indexPath.row >= 0 && indexPath.row <= 6
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var numberOfMonths : Int? = startDate?.numberOfMonthsUntilEndDate(self.endDate!)
        return numberOfMonths == nil ? 0 : numberOfMonths!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let firstDayOfMonth : NSDate? = startDate?.firstDayOfMonth().dateByAddingMonths(section)
        let lastDayOfMonth : NSDate? = firstDayOfMonth?.lastDayOfMonth()
        let days_in_week : Int = 7
        var numberOfDays : Int? = firstDayOfMonth?.numberOfDaysInMonth()
        numberOfDays == nil ? 0 : numberOfDays!
        var offsetDays : Int? = firstDayOfMonth?.weekday()
        var remainderDays : Int = days_in_week - lastDayOfMonth!.weekday()
        
        return numberOfDays! + offsetDays! + remainderDays + days_in_week
    }
    
    // Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (self.isWeekDay(indexPath)) {
            var cell : CLCalendarWeekDayCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("WeekDayCell", forIndexPath: indexPath) as CLCalendarWeekDayCollectionViewCell
            cell.weekDayLabel(weekDayLbls[indexPath.row])
            
            return cell
        } else {
            let firstDayOfMonth : NSDate? = startDate?.firstDayOfMonth().dateByAddingMonths(indexPath.section)
            let date: NSDate = dateForIndexPath(indexPath)
            var cell : CLCalendarDayCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("DayCell", forIndexPath: indexPath) as CLCalendarDayCollectionViewCell
            cell.date = date
            cell.outsideCurrentMonth = firstDayOfMonth?.month() != date.month()
            
            return cell
        }
    }
    
    // Section
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if ( kind == UICollectionElementKindSectionHeader ) {
            let firstDayOfMonth: NSDate = dateForIndexPath(indexPath).firstDayOfMonth()
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as CLCalendarHeaderCollectionReusableView
            header.firstDayOfMonth = firstDayOfMonth
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(self.frame.width, 50)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if (self.isWeekDay(indexPath)) {
            return CGSizeMake(daySize.width, weekDayHeight)
        }
        
        return daySize
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let date: NSDate = dateForIndexPath(indexPath)
        dates.append(date)
        
        if (delegate != nil) {
            delegate?.calendarView(self, didSelectDate: date)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let date: NSDate = dateForIndexPath(indexPath)
        let index: Int? = find(dates, date) as Int?
        if (index != nil) {
            dates.removeAtIndex(index!)
        }
        
        if (delegate != nil) {
            delegate?.calendarView(self, didDeselectDate: date)
        }
    }
    
}
