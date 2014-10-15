//
//  CLCalendarDayCollectionViewCell.swift
//  CLCalendarDemo
//
//  Created by Christian Torres on 10/14/14.
//  Copyright (c) 2014 Christian Torres. All rights reserved.
//

import UIKit

class CLCalendarDayCollectionViewCell: UICollectionViewCell {
    
    // Public properties
    var date: NSDate! {
        didSet {
            titleLabel.text = CLCalendarDayStringFromDate(date)
        }
    }
    var outsideCurrentMonth: Bool! = false {
        didSet {
            if (outsideCurrentMonth!) {
                titleLabel.textColor = outsideCurrentMonthTextColor
            } else {
                titleLabel.textColor = insideCurrentMonthTextColor
            }
        }
    }
    var insideCurrentMonthTextColor: UIColor! = UIColor.whiteColor()
    var outsideCurrentMonthTextColor: UIColor! = UIColor(red: 141/255, green: 142/255, blue: 143/255, alpha: 1)
    var insideCurrentMonthHighlightTextColor: UIColor! = UIColor.blackColor()
    var highlightColor: UIColor! = UIColor(red: 160/255, green: 241/255, blue: 80/255, alpha: 1) {
        didSet {
            highlightView.backgroundColor = highlightColor
        }
    }
    
    // Overriden
    override var selected: Bool {
        didSet {
            highlightView.hidden = !selected
            titleLabel.textColor = selected ? insideCurrentMonthHighlightTextColor : insideCurrentMonthTextColor
            
            if (!oldValue && selected) {
                highlightView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                UIView.animateWithDuration(0.4,
                    delay: 0.0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 1.0,
                    options: .CurveEaseIn,
                    animations: { () -> Void in
                        self.highlightView.transform = CGAffineTransformIdentity
                    },
                    completion: { (finished: Bool) -> Void in
                })
            }
        }
    }
    
    // Private properties
    private var titleLabel: UILabel!
    private var highlightView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewSize: CGSize = contentView.bounds.size
        let highlightViewInset:CGFloat = viewSize.height * 0.1; // bounds of highlight view 10% smaller than cell
        highlightView = UIView(frame: CGRectInset(contentView.frame, highlightViewInset, highlightViewInset))
        highlightView.hidden = true;
        highlightView.layer.cornerRadius = CGRectGetHeight(highlightView.bounds) / 2
        highlightView.backgroundColor = highlightColor
        
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = insideCurrentMonthTextColor
        
        contentView.addSubview(highlightView)
        contentView.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func CLCalendarDayStringFromDate(date: NSDate) -> String {
        return String(format: "%d", date.day());
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
}
