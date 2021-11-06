//
//  AppDelegate.swift
//  attendence
//
//  Created by Amal on 28/03/1443 AH.
//

import UIKit
class TabBarController: UITabBarController {
 fileprivate func createNavController(for rootViewController: UIViewController,
              title: String,
              image: UIImage) -> UIViewController {
     
   let navController = UINavigationController(rootViewController: rootViewController)
   navController.tabBarItem.title = title
   navController.tabBarItem.image = image
   navController.navigationBar.prefersLargeTitles = true
   rootViewController.navigationItem.title = title
   return navController
  }
    
 func setupVCs() {
   viewControllers = [
    createNavController(for: ViewController(), title: NSLocalizedString("Students", comment: ""), image: UIImage(systemName: "person")!),
    createNavController(for: EntryViewController(), title: NSLocalizedString("Days", comment: ""), image: UIImage(systemName: "person")!)
    ]
  }
 override func viewDidLoad() {
  super.viewDidLoad()
  view.backgroundColor = .systemBackground
   UITabBar.appearance().barTintColor = .systemBackground
   tabBar.tintColor = .label
   setupVCs()
 }
}





