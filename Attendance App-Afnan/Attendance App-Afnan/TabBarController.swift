//
//  TabBarController.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 28/03/1443 AH.
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
              createNavController(for: StudentsVC(), title: NSLocalizedString("Students", comment: ""), image: UIImage(systemName: "person.3")!),
              createNavController(for: DaysVC(), title: NSLocalizedString("Days", comment: ""), image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis")!),
             
          ]
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
           tabBar.backgroundColor = .systemMint
           tabBar.tintColor = .black
           setupVCs()

        // Do any additional setup after loading the view.
    }

}
