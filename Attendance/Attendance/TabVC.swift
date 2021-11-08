//
//  TabVC.swift
//  AttendanceApp
//


import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
 override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
 }
 override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let item1 = DateList()
    let item2 = StudentsList()

    let icon1 = UITabBarItem(title: "Days", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
     
    let icon2 = UITabBarItem(title: "Students", image: UIImage(systemName: "person.3.fill"), selectedImage: UIImage(systemName: "person.3.fill"))
     
    item1.tabBarItem = icon1
    item2.tabBarItem = icon2

    let controllers = [item1,item2]
     self.viewControllers = controllers
 }
 func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
 }
}

