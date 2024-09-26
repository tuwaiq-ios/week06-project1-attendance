//
//  Students list.swift
//  attendance
//
//  Created by Hassan Yahya on 28/03/1443 AH.
//

import UIKit

import FirebaseFirestore
import Firebase




class StudentsVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
	let BtnAdd = UIButton()
	let TV1 = UITableView()
	var Addnews : Array<Students> = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
  
		StudentsService.shared.listenToStudents { newStudents in
			self.Addnews = newStudents
			self.TV1.reloadData()
		}
		
		
		TV1.dataSource = self
		TV1.delegate = self
		
		
		TV1.register(Cell.self, forCellReuseIdentifier: "cell")
		TV1.backgroundColor = .white
		TV1.rowHeight = 80
		TV1.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(TV1)
		NSLayoutConstraint.activate([
			TV1.leftAnchor.constraint(equalTo: view.leftAnchor),
			TV1.rightAnchor.constraint(equalTo: view.rightAnchor),
			TV1.topAnchor.constraint(equalTo: view.topAnchor),
			TV1.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
		])
		view.addSubview(BtnAdd)
		BtnAdd.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

			BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
		])
		//BtnAdd.backgroundColor = .orange
		// BtnAdd.addTarget(self, action: #selector(a), for: .touchUpInside)
		BtnAdd.backgroundColor = UIColor.gray
		BtnAdd.setTitle("+ Student ", for: .normal)
		BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		self.view.addSubview(BtnAdd)
		

	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Addnews.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contact = Addnews[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		as! Cell
		cell.textLabel?.text = "\(contact.name!)"
		
		return cell
	}
	


	
	@objc func buttonAction(sender: UIButton!) {
		
		let secondController = AddStudent()
			
	   
		present(secondController, animated: true, completion: nil)
	   
	}
	
}

class Cell: UITableViewCell {
   
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style , reuseIdentifier: reuseIdentifier )
	
		
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}


