//
//  NSDate+CLCalendar.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/15/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import Foundation


// MARK: Helpers
private func CLCalendarDateFromComponents(components: NSDateComponents) -> NSDate {
    let calendar : NSCalendar = NSCalendar.currentCalendar()
    
    return calendar.dateFromComponents(components)!
}

extension NSDate {
    
    func dateByAddingMonths(months: Int) -> NSDate {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        
        let components : NSDateComponents = NSDateComponents()
        components.month = months
        
        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0))!
    }
    
    private func CLCalendarDateComponentsFromDate(date: NSDate) -> NSDateComponents {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        
        return calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.WeekCalendarUnit|NSCalendarUnit.WeekdayCalendarUnit|NSCalendarUnit.DayCalendarUnit, fromDate:self)
    }
    
    func firstDayOfMonth() -> NSDate {
        let components : NSDateComponents = CLCalendarDateComponentsFromDate(self)
        components.day = 1
        
        return CLCalendarDateFromComponents(components)
    }
    
    func lastDayOfMonth() -> NSDate {
        let components : NSDateComponents = CLCalendarDateComponentsFromDate(self)
        let month : Int = components.month

        components.month = month + 1
        components.day = 0
        
        return CLCalendarDateFromComponents(components)
    }
    
    func numberOfDaysInMonth() -> Int {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let firstDayOfMonth : NSDate = self.firstDayOfMonth()
        let lastDayOfMonth : NSDate = self.lastDayOfMonth()
        let components : NSDateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: firstDayOfMonth, toDate: lastDayOfMonth, options: NSCalendarOptions(0))
        
        return components.day;
    }
    
    func numberOfMonthsUntilEndDate(endDate: NSDate) -> Int {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let components : NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate:self, toDate:endDate, options: NSCalendarOptions(0))
    
        return components.month
    }
    
    func month() -> Int {
        let components : NSDateComponents = CLCalendarDateComponentsFromDate(self);
        return components.month;
    }
    
    func components() -> NSDateComponents {
        return CLCalendarDateComponentsFromDate(self)
    }
    
    func weekday() -> Int {
        let components : NSDateComponents = CLCalendarDateComponentsFromDate(self)
        return components.weekday
    }
    
    func day() -> Int {
        let components: NSDateComponents = CLCalendarDateComponentsFromDate(self)
        return components.day
    }
    
    
    func dateByAddingDays(days: Int) -> NSDate {
        let components: NSDateComponents = NSDateComponents()
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        
        components.day = days;
    
        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0))!
    }
    
    // READ: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW13
    func strftime(format: String) -> String {
        let formatter: NSDateFormatter =  NSDateFormatter()
//        let locale: NSLocale =  NSLocale(localeIdentifier: )
//        dateFormatter.locale = locale
        formatter.dateFormat = format
        
        return formatter.stringFromDate(self)
    }
    
    // MARK: Class methods
    
    class func dateFromComponents(components: NSDateComponents) -> NSDate {
        return CLCalendarDateFromComponents(components)
    }

}