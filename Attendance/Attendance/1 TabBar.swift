//
//  Attendance
//
//  Created by Fawaz on 06/11/2021.
//

import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate {
  
  //==========================================================================
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    
    let item1 = Date_TabBar()
    let item2 = Student_TabBar()
    
    let icon1 = UITabBarItem(
      title: "Date", image: UIImage(systemName: "calendar.circle"),
      selectedImage: UIImage(systemName: "calendar.circle")
    )
    
    let icon2 = UITabBarItem(
      title: "Students", image: UIImage(systemName: "person.circle"),
      selectedImage: UIImage(systemName: "person.circle")
    )
    
    item1.tabBarItem = icon1
    item2.tabBarItem = icon2
    
    let controllers = [item1,item2]
    self.viewControllers = controllers
  }
  //==========================================================================
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  //==========================================================================
  func tabBarController(_ tabBarController: UITabBarController,
                        shouldSelect viewController: UIViewController) -> Bool {
    
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
  }
  //==========================================================================

} //class end
