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
    @IBOutlet weak var moneyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        textChanged(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textChanged(sender: AnyObject?) {
        moneyLabel.text = "Double value: \(moneyField.numberValue.doubleValue)"
    }
    
}

