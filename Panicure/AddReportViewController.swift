//
//  AddReportViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-06.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class AddReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var whereField: UITextField!
    @IBOutlet weak var whenField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var severitySegment: UISegmentedControl!
    
    var savedImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageButton.setBackgroundImage(image, forState: .Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.savedImage = true
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
        
        if (self.savedImage) {
        let data = UIImageJPEGRepresentation(self.imageButton.backgroundImageForState(.Normal)!, 0.5)
        let imageFile = PFFile(data: data!)
        imageFile!.saveInBackground()
        newReport.image = imageFile
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
