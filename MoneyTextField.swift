//
//  MoneyTextField.swift
//  MoneyTextFIeld
//
//  Created by Adam Hartford on 5/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import UIKit

class MoneyTextField: UITextField {
    
    let nonDecimal = NSCharacterSet(charactersInString: "0123456789").invertedSet
    let numberFormatter = NSNumberFormatter()
    
    var negative = false {
        didSet {
            text = format(numberFormatter.stringFromNumber(numberValue)!)
        }
    }
    
    var prevRange: UITextRange?
    var positiveColor = UIColor.greenColor()
    var negativeColor = UIColor.redColor()
    var defaultColor: UIColor!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberFormatter.numberStyle = .CurrencyStyle
        addTarget(self, action: "editingChanged", forControlEvents: .EditingChanged)
        
        text = format(numberFormatter.stringFromNumber(NSNumber(int: 0))!)
    }
    
    func editingChanged() {
        text = format(numberFormatter.stringFromNumber(numberValue)!)
        if let range = prevRange {
            selectedTextRange = range
            prevRange = nil
        }
    }
    
    override func deleteBackward() {
        prevRange = selectedTextRange
        
        let loc = offsetFromPosition(beginningOfDocument, toPosition: selectedTextRange!.start)
        
        let selection = textInRange(selectedTextRange!)
        if selection == "" {
            let prev = (text as NSString).characterAtIndex(loc - 1)
            if prev >= 48 && prev <= 57 { // ASCII characters 0...9
                super.deleteBackward()
                return
            }
        } else {
            super.deleteBackward()
            return
        }
        
        text = numberFormatter.stringFromNumber(NSNumber(double: numberValue.doubleValue  / 10))
        text = format(text)
    }
    
    func format(s: String) -> String {
        var val = numberValue.doubleValue
        
        if val == 0 {
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
    
    var numberValue: NSNumber {
        let s = text as NSString
        let arr = s.componentsSeparatedByCharactersInSet(nonDecimal) as NSArray
        let n = arr.componentsJoinedByString("") as NSString
        
        var d = n.doubleValue / base
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
