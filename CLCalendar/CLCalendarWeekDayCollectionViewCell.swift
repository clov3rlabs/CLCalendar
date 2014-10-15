//
//  CLCalendarWeekDayCollectionViewCell.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/15/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import UIKit

class CLCalendarWeekDayCollectionViewCell: UICollectionViewCell {
    
    // Private properties
    private var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10.0)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func weekDayLabel(weekDayLabel: String) {
        titleLabel.text = weekDayLabel
    }
    
}
