//
//  File.swift
//  Attendess2
//
//  Created by Hanan on 29/03/1443 AH.
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
    createNavController(for: StudentPage(), title: NSLocalizedString("Students", comment: ""), image: UIImage(systemName: "person")!),
    createNavController(for: DaysPage(), title: NSLocalizedString("Days", comment: ""), image: UIImage(systemName: "person")!)
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





