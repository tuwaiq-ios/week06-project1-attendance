//
//  TabVC.swift
//  SaraAttended
//
//  Created by sara saud on 11/7/21.
//

import Foundation
import UIKit


class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewControllers = [
            StudentsVC(),DaysVC()
           
        ]
    }
}
