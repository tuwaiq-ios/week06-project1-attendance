//
//  TabBarViewController.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor                  = .systemBackground
        UITabBar.appearance().barTintColor    = .systemBackground
        tabBar.tintColor                      = .label
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
          let navController              = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = image
        
          navController.navigationBar.prefersLargeTitles = true
          rootViewController.navigationItem.title        = title
        
          return navController
      }
    
    func setupVCs() {
          viewControllers = [
            createNavController(for: DaysViewController(),
                                   title: NSLocalizedString("Days", comment: ""),
                                   image: UIImage(systemName: "deskclock")!),
              createNavController(for: StudentViewController(),
                                     title: NSLocalizedString("Students", comment: ""),
                                     image: UIImage(systemName: "person")!)
          ]
      }
}
