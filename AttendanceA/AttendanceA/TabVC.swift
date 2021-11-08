
import Foundation
import UIKit


class TabVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .red
		viewControllers = [
			StudentsVC(),
			DaysVC()
		]
	}
}
