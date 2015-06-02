//
//  ViewController.swift
//  MoneyTextField Example
//
//  Created by Adam Hartford on 5/23/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moneyField: MoneyTextField!
    @IBOutlet weak var moneyStepper: UIStepper!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var localeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        textChanged(nil)
        updateLocale(NSLocale.currentLocale())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textChanged(sender: AnyObject?) {
        moneyLabel.text = "Double value: \(moneyField.numberValue.doubleValue)"
    }
    
    @IBAction func moneyStepperChanged(sender: AnyObject?) {
        moneyField.negative = moneyStepper.value < 0
        textChanged(nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLocales" {
            let controller = segue.destinationViewController as! LocaleViewController
            controller.didSelectLocale = updateLocale
        }
    }
    
    func updateLocale(locale: NSLocale) {
        moneyField.locale = locale
        let name = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: locale.localeIdentifier)
        localeButton.setTitle(name, forState: .Normal)
    }
    
}

