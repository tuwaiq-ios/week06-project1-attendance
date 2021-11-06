//
//  prsentpage.swift
//  attendance
//
//  Created by Hassan Yahya on 29/03/1443 AH.
//

import Foundation
import UIKit

class PrsentPage: UIViewController , UITableViewDataSource, UITableViewDelegate {
	
	let TV2 = UITableView()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		TV2.dataSource = self
		TV2.delegate = self
		TV2.register(Cell2.self, forCellReuseIdentifier: "cell")
		TV2.backgroundColor = .white
		TV2.rowHeight = 80
		TV2.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(TV2)
		NSLayoutConstraint.activate([
			TV2.leftAnchor.constraint(equalTo: view.leftAnchor),
			TV2.rightAnchor.constraint(equalTo: view.rightAnchor),
			TV2.topAnchor.constraint(equalTo: view.topAnchor),
			TV2.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
		])
		
		
		
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Addn.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contact = Addn[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		as! Cell2
		cell.namecell.text = "\(contact.name)"
		
		return cell
	}
}

class Cell2: UITableViewCell {
	
	let namecell = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
		super.init(style: style , reuseIdentifier: reuseIdentifier )
		
		
		
		namecell.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(namecell)
		NSLayoutConstraint.activate(
			[namecell.centerYAnchor.constraint(equalTo: centerYAnchor),
			 namecell.centerXAnchor.constraint(equalTo: centerXAnchor)])
		
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}


