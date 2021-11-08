//
//  TabVC.swift
//  NEWAttendanceApp
//
//  Created by dmdm on 08/11/2021.
//

import Foundation
import UIKit


class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        viewControllers = [
            StudentsVC(),
            DaysVC()
        ]
    }
}
