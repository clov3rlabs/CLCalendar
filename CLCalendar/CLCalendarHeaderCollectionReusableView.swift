//
//  CLCalendarMonthCollectionReusableView.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/15/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import UIKit

class CLCalendarHeaderCollectionReusableView: UICollectionReusableView {
    
    // Public properties
    var dateFormat: String! = "MMMM yyyy"
    var firstDayOfMonth: NSDate! {
        didSet {
            self.titleLabel.text = firstDayOfMonth.strftime(dateFormat).capitalizedString
        }
    }
    
    // Private properties
    private var titleLabel : UILabel!
    
    // Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        var rect: CGRect = self.bounds
        let font: UIFont = UIFont(name: "HelveticaNeue-Medium", size: 17.5)
        rect.size.height = 30.0
        rect.origin.y = frame.size.height - rect.size.height
        titleLabel = UILabel(frame: rect)
        titleLabel.font = font
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private Methods
    
    
    
}
