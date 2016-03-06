//
//  AddReportViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-06.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class AddReportViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var whereField: UITextField!
    @IBOutlet weak var whenField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var severitySegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        let newReport = Report()
        newReport.location = whereField.text
        newReport.when = whenField.text
        newReport.detail = descriptionField.text
        newReport.user = PFUser.currentUser()
        
        switch severitySegment.selectedSegmentIndex {
        case 0:
            newReport.severity = "Moderate"
        case 1:
            newReport.severity = "Severe"
        case 2:
            newReport.severity = "Extreme"
        default:
            break
        }
        
        newReport.saveInBackgroundWithBlock({(success: Bool, error: NSError?) in
            print(success)
            if (error == nil && success) {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                print(error)
            }
        })
        
    }
}
