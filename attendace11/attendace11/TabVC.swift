//
//  TabVC.swift
//  attendace11
//
//  Created by  m.alqahtani on 02/04/1443 AH.
//

import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let item2 = DateList()
        let item3 = StudentsVC()
        let icon2 = UITabBarItem(title: "days", image: UIImage(systemName: "timer"), selectedImage: UIImage(systemName: "timer"))
        let icon3 = UITabBarItem(title: "students", image: UIImage(systemName: "person.fill.badge.plus"), selectedImage: UIImage(systemName: "person.fill.badge.plus"))

        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        let controllers = [item2,item3]
        //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // TabVC.reloadData()
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
