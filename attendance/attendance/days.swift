//
//  date list.swift
//  attendance
//
//  Created by Hassan Yahya on 28/03/1443 AH.
//

import UIKit


class DateList : UIViewController , UITableViewDelegate ,UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todayday.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
		
		let day =  todayday[indexPath.row]
		let pStudentCount = day.pStudents.count
		let aStudentCount = studentCount - pStudentCount
		
		cell.textLabel?.text = day.getNiceDate()
		cell.detailTextLabel?.text = "P: \(pStudentCount), A: \(aStudentCount)"
		
		return cell

	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let day = todayday[indexPath.row]
		
		let navigationController = UINavigationController(
			rootViewController: PrsentPage(dayId: day.id)
		)
		navigationController.navigationBar.prefersLargeTitles = true
		
		present(navigationController, animated: true, completion: nil)
		
		
	}
	
	var todayday : Array<Day> = []
	var studentCount = 0
	let TV = UITableView()
	let BtnAdd = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		DaysService.shared.listenToDays { newDays in
			self.todayday = newDays
			self.TV.reloadData()
		}
		StudentsService.shared.listenToStudentCount { newStudentCount in
			self.studentCount = newStudentCount
			self.TV.reloadData()
		}
		
		
		TV.delegate = self
		TV.dataSource = self
		
		TV.translatesAutoresizingMaskIntoConstraints = false
		TV.register(CellDays.self, forCellReuseIdentifier: "cell")
		view.addSubview(TV)
		
		NSLayoutConstraint.activate([
			TV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			TV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			TV.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			TV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
		])
		
		BtnAdd.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(BtnAdd)
		
		NSLayoutConstraint.activate([
			BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

			BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
		])
//
//		NSLayoutConstraint.activate([
//			BtnAdd.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//			BtnAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//			BtnAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//			BtnAdd.heightAnchor.constraint(equalToConstant: 210)
//		])
	 
		BtnAdd.backgroundColor = UIColor.gray
		BtnAdd.setTitle("+ Day", for: .normal)
		BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		self.view.addSubview(BtnAdd)
		
		
	}
	
	@objc func buttonAction(sender: UIButton!) {
		
		let secondController = DatePicer()
		secondController.callbackClosure = { [weak self] in
			
			self?.TV.reloadData()
		}
		present(secondController, animated: true, completion: nil)
		
	}
	
}



class CellDays: UITableViewCell {
	
	let Label8 = UILabel()
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style , reuseIdentifier: reuseIdentifier )
		
		
	
		
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
