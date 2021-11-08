//
//  Tabbar.swift
//  attendance app
//
//  Created by Ahmed Assiri on 01/04/1443 AH.
//


import Foundation
import UIKit

class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        viewControllers = [StudentsVC(),Class()]
    }
}
