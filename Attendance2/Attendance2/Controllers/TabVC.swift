//
//  TabVC.swift
//  Attendance2
//
//  Created by Tsnim Alqahtani on 02/04/1443 AH.
//

import Foundation
import UIKit


class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        viewControllers = [
            StudentsVC(),
            DaysVC()
        ]
    }
}
