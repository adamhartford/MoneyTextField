//
//  LocaleViewController.swift
//  MoneyTextField
//
//  Created by Adam Hartford on 6/2/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import UIKit

class LocaleViewController: UITableViewController {

    var didSelectLocale: ((NSLocale) -> ())?

    var identifiers = NSLocale.availableLocaleIdentifiers() as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identifiers.sort { $0 < $1 }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let identifier = identifiers[indexPath.row]
        let name = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: identifier)!
        cell.textLabel!.text = identifier
        cell.detailTextLabel!.text = name

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let locale = NSLocale(localeIdentifier: identifiers[indexPath.row])
        didSelectLocale?(locale)
        navigationController!.popViewControllerAnimated(true)
    }

}
