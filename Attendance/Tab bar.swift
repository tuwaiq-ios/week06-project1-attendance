//
//  Tab bar.swift
//  Attendance
//
//  Created by Tsnim Alqahtani on 28/03/1443 AH.
//



import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
      title = "Attend me 👩🏻‍💼"
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
      
  
    let Days = DatePiker()
    let item1 = DaysViewController ()
      
      let icon11 = UITabBarItem(title: "Days", image: UIImage(systemName: "contextualmenu.and.cursorarrow"), selectedImage: UIImage(systemName: "contextualmenu.and.cursorarrow"))
 
      
    let icon2 = UITabBarItem(title: "Student", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))

      item1.tabBarItem = icon11
 
     Days.tabBarItem = icon2
      
    let controllers = [item1,Days] //array of the root view controllers displayed by the tab bar interface
    self.viewControllers = controllers
  }
}


