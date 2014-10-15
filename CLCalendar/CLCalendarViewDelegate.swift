//
//  CLCalendarViewDelegate.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/23/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import Foundation

protocol CLCalendarViewDelegate {
    
    // Reports the selected date.
    func calendarView(calendarView: CLCalendarView, didSelectDate date: NSDate)
    
    // Reports the unselected date.
    func calendarView(calendarView: CLCalendarView, didDeselectDate date: NSDate)
    
    // TODO: Implement this delegate method to specify which dates should be selectable.
    // Non-selectable dates' cells are shown with 20% background opacity.
//    func calendarView(calendarView: CLCalendarView, shouldSelectDate date: NSDate)
    
}