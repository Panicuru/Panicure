//
//  ReportsViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-06.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class ReportsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var panicButton: UIButton!
    
    var reports: [Report] = [Report]()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchReportsForUser()
    }
    
    func fetchReportsForUser() {
        let query = PFQuery(className: "Report")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock({(results: [PFObject]?, error: NSError?) in
            if let reports = results as? [Report] {
                self.reports.appendContentsOf(reports)
            }
        })
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("reportCell") as? ReportTableViewCell {
            let report = self.reports[indexPath.row]
            cell.addressLabel.text = report.location
            cell.dateLabel.text = String(report.createdAt)
            cell.severityLabel.text = report.severity
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reports.count
    }

}
