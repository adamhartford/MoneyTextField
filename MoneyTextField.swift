//
//  MoneyTextField.swift
//  MoneyTextFIeld
//
//  Created by Adam Hartford on 5/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import UIKit

public class MoneyTextField: UITextField {
    
    let nonDecimal = NSCharacterSet(charactersInString: "0123456789").invertedSet
    let numberFormatter = NSNumberFormatter()
    
    public var negative = false {
        didSet {
            text = format(numberFormatter.stringFromNumber(numberValue)!)
        }
    }
    
    public var locale = NSLocale.currentLocale() {
        didSet {
            numberFormatter.locale = locale
            text = format(numberFormatter.stringFromNumber(numberValue)!)
        }
    }
    
    var prevRange: UITextRange?
    // Flat color Nephritis
    public var positiveColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
    // Flat color Pomegranate
    public var negativeColor = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1)
    var defaultColor: UIColor!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberFormatter.numberStyle = .CurrencyStyle
        addTarget(self, action: "editingChanged", forControlEvents: .EditingChanged)
        
        defaultColor = textColor
        text = format(numberFormatter.stringFromNumber(NSNumber(int: 0))!)
    }
    
    func editingChanged() {
        text = format(numberFormatter.stringFromNumber(numberValue)!)
        if let range = prevRange {
            selectedTextRange = range
            prevRange = nil
        }
    }
    
    public override func deleteBackward() {
        prevRange = selectedTextRange
        
        let loc = offsetFromPosition(beginningOfDocument, toPosition: selectedTextRange!.start)
        
        let selection = textInRange(selectedTextRange!)
        if selection == "" {
            let prev = (text! as NSString).characterAtIndex(loc - 1)
            if prev >= 48 && prev <= 57 { // ASCII characters 0...9
                super.deleteBackward()
                return
            }
        } else {
            super.deleteBackward()
            return
        }
        
        let temp = abs(numberValue.doubleValue / 10)
        let s: NSString = "\(temp)"
        let val = (s.substringToIndex(s.length - 1) as NSString).doubleValue
        
        text = format(numberFormatter.stringFromNumber(NSNumber(double: val))!, val: val)
        sendActionsForControlEvents(UIControlEvents.EditingChanged)
    }
    
    func format(s: String, val: Double? = nil) -> String {
        var v = val
        if v == nil {
            v = numberValue.doubleValue
        }
        
        if v == 0 {
            textColor = defaultColor
            return s
        } else if !negative {
            textColor = positiveColor
            return s
        } else {
            textColor = negativeColor
            return "(" + s.stringByReplacingOccurrencesOfString("-", withString: "") + ")"
        }
    }
    
    public var numberValue: NSNumber {
        let s = text! as NSString
        let arr = s.componentsSeparatedByCharactersInSet(nonDecimal) as NSArray
        let n = arr.componentsJoinedByString("") as NSString
        
        var d = n.doubleValue / base * (negative ? -1 : 1)
        if d == -0 {
            d = 0
        }
        return NSNumber(double: d)
    }
    
    var base: Double {
        let test = numberFormatter.stringFromNumber(NSNumber(int: 0))! as NSString
        return test.containsString(".") || test.containsString(",") ? 100 : 1
    }
    
}
