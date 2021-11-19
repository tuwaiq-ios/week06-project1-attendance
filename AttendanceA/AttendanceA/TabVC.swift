
import Foundation
import UIKit


class TabVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        
//        UITabBar.appearance().barTintColor = .black
		view.backgroundColor = .red
		viewControllers = [
			StudentsVC(),
			DaysVC()
		]
	}
}

