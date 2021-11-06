//
//  tabBar.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let item1 = ViewController ()
        let item2 = Days()
      //  let item3 = StudentsList()
        let icon1 = UITabBarItem (title: "Students", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))

        let icon2 = UITabBarItem(title: "Days", image: UIImage(systemName: "contextualmenu.and.cursorarrow"), selectedImage: UIImage(systemName: "contextualmenu.and.cursorarrow"))
      //  let icon3 = UITabBarItem(title: "ss", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
       // item3.tabBarItem = icon3
        let controllers = [item1,item2] //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }

}
