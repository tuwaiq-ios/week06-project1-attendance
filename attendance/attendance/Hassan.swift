////
////  hassan.swift
////  attendance
////
////  Created by Hassan Yahya on 29/03/1443 AH.
////
//
//import UIKit
//import FirebaseFirestore
//
//
//struct Student {
//	let name: String
//	var attendance: Bool
//}
//class ViewController: UIViewController,
//					  UITableViewDelegate,
//					  UITableViewDataSource{
//	
//	let tv = UITableView()
//	let attandanceLabel = UILabel()
//	var studetns = [Student]()
//	
//	override func viewDidLoad(){
//		super.viewDidLoad()
//		tv.delegate = self
//		tv.dataSource = self
//		tv. translatesAutoresizingMaskIntoConstraints = false
//		tv.backgroundColor = .orange
//		tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//		view.addSubview(tv)
//		
//		NSLayoutConstraint.activate([
//			
//		])
//		
//		view.addSubview(attandanceLabel)
//		
//		attandanceLabel.translatesAutoresizingMaskIntoConstraints = false
//		NSLayoutConstraint.activate([
//			attandanceLabel.topAnchor.constraint(equalTo:view.topAnchor,constant:50),
//			attandanceLabel.leftAnchor.constraint(equalTo:view.leftAnchor),
//			attandanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
//			attandanceLabel.text = "Students count = \(studetns.filter({ student in student.attendance }).count)"
//			
//			Firestore.firestore().collection("studetns").addSnapshotListener {
//				(snapshot, error in
//				 if error != nil {
//					print(error as Any)
//					return
//				}
//				 var studentsArray = [Student]()
//				 for document in snapshot!.documents {
//					let data = document.data()
//					studetnsArray.append(
//						Students(
//							id: data["id"]as! String,
//							name: data["name"]as! String,
//							attendance: data["attendance"]as! Bool
//						)
//					)
//				}
//				 self.attandanceLabel.text = "Students count = \(studetnsArray.filter({ student in student.attendance}).count)"
//				 self.studetns = studentsArray
//				 self.tv.reloadData()
//				 }
//				 }
//				 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//					return studetns.count
//					
//				}
//				 
//				 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//					let cell = tableView.dequeueReusableCell(withIdentifier:"Cell",for: indexPath)
//					let student = studetns[indexPath.row]
//					cell.textLabel?.text = student.name
//					
//					=====
//					
//					Firestore.firestore().collection("students").addSnapshotListener{snapshot,errorin
//						if error != nil f
//							print(error as Any)
//							return 7
//							var studetnsArray = [Student]()
//							for document in snapshot!.documents {
//							let data = document.data()
//							studetnsArray.append(
//								Student(
//									id: datal"id"] as! String,
//									name: data["name"] as! String,
//									attendance: data["attendance"] as! Bool
//								)
//								7
//							
// self.attandanceLabel.text = "Students count = \(studetnsArrav.filter({ student in student.attendance
//}).count)"
//								self.studetns = studetnsArray
//								self.tv.reloadData()
//								1
//								========
//								
//								
//								ViewController M tableView(_:didSelectRowAt:)
//								04
//								ELSe
//								85
//								cell. backgroundColor
//								= .systemPink
//								86
//								}
//								87
//								88
//								return cell
//								89
//								90
//								91
//								92
//								93
//								94
//								95
//								96
//								97
//								98
//								}
//								99
//								100
//								101
//								}
//								102
//								Running dav28 on iPhone 13 Prc
//								func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//									tableView.deselectRow(at: indexPath, animated: false)
//									let student = studetns[indexPath.row]
//									studetns[indexPath.row].attendance = !student.attendance
//									Firestore.firestore().document ("students/\(student.id)") .updateData(fields: [AnyHashable : Any])
//									attandanceLabel.text=
//									"Students count = \(studetns.filter({ student in student.attendance }).count)"
//									tableView.reloadData()
//									
//									
//									========
//									
//									func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//										tableView.deselectRow(at: indexPath, animated: false)
//										let student = studetns[indexPath.row]
//										studetns[irdexPath.row].attendance = !student.attendance
//										Firestore.firestore()
//										document("students/\(student.id)")
//										updateData(["attendance": I student.attendance])
//										attandanceLabel.text = "Students count = \(studetns.filter({ student in student.attendance }).count)"
//										tableView.reloadData()
