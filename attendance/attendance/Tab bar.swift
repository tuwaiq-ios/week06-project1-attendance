//
//  Tap bar.swift
//  attendance
//
//  Created by Hassan Yahya on 28/03/1443 AH.
//

import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let item2 = DateList()
		let item3 = ViewController()
		let icon2 = UITabBarItem(title: "Days", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
		let icon3 = UITabBarItem(title: "Students", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
		item2.tabBarItem = icon2
		item3.tabBarItem = icon3
		let controllers = [item2,item3]
		self.viewControllers = controllers
	}
}
func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
	print("Should select viewController: \(viewController.title ?? "") ?")
	return true;
}
