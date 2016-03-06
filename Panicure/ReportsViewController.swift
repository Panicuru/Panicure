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
    var images: [String: NSData?] = [String: NSData?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.panicButton.layer.cornerRadius = 4.0
        self.panicButton.layer.masksToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchReportsForUser()
    }
    
    func fetchReportsForUser() {
        let query = PFQuery(className: "Report")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock({(results: [PFObject]?, error: NSError?) in
            if let reports = results as? [Report] {
                self.reports = reports
            }
            self.tableView.reloadData()
            
            for report in self.reports {
                report.encryptDecrypt()
                if (report.image != nil) {
                    report.image?.getDataInBackgroundWithBlock({(imageData: NSData?, error:NSError?) in
                        self.images[report.objectId!] = imageData
                        self.tableView.reloadData()
                    })
                } else {
                    self.images[report.objectId!] = nil
                }
            }
        })
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("reportCell") as? ReportTableViewCell {
            let report = self.reports[indexPath.row]
            cell.addressLabel.text = report.location
            cell.reportDetail.text = report.detail
            cell.dateLabel.text = report.when
            cell.severityLabel.text = report.severity
            
            let data = self.images[report.objectId!]
            
            if data != nil {
                let image = UIImage(data: data!!)
                cell.reportImageView.image = image
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reports.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock({(error: NSError?) in
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        })
    }
    
    @IBAction func startPanicing(sender: AnyObject) {
        PanicHelper.startPanicingWithCompletion { (error: NSError?, panic: Panic?) in
            let message = error == nil ? "Success" : "error"
            self.performSegueWithIdentifier("panicSuccess", sender: self)
        }
    }
}
