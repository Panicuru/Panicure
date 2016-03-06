//
//  ProfileInfoViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    
    var currentIndex: Int = 0
    var views: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func userDidCompleteForm(withObject profile: Profile) {
        
    }
    
    func userDidCancelEditing() {
        
    }

}
