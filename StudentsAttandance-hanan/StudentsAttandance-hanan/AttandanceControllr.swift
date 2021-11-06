//
//  AttandanceControllr.swift
//  StudentsAttandance-hanan
//
//  Created by  HANAN ASIRI on 30/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore


struct Student {
 let id: String
 let name: String?
 var attandance: Bool
}

class AttandanceController: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
   let tv = UITableView()
    let attanlable = UILabel()
    var students = [Student]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .orange
        view.addSubview(tv)
        NSLayoutConstraint.activate ([
            tv.topAnchor.constraint(equalTo: view.topAnchor),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tv.leftAnchor.constraint(equalTo: view.leftAnchor),
            tv.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
            view.addSubview(attanlable)
            attanlable.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate ([
                attanlable.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                attanlable.leftAnchor.constraint(equalTo: view.leftAnchor),
                attanlable.rightAnchor.constraint(equalTo: view.rightAnchor),
                
        ])
        attanlable.text = "student count = \(students.filter({ student in student.attandance }).count)"
        Firestore.firestore().collection("students").addSnapshotListener{ snapshot, error in
            if error != nil {
                print(error)
                return
            }
            
            var studentArray = [Student]()
            for document in snapshot!.documents {
                let data = document.data()
                studentArray.append(
                    Student(
                        id:data ["id"] as! String,
                        name:data ["name"] as! String,
                    attandance:data["attendance"] as! Bool
                )
            )
            }
            self.students = studentArray
            self.tv.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        
        if student.attandance {
            cell.backgroundColor = .purple
        } else {
            cell.backgroundColor = .cyan
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tv.deselectRow(at: indexPath, animated: false)
        let student = students[indexPath.row]
        students[indexPath.row].attandance = !students[indexPath.row].attandance
        
        Firestore.firestore()
            .document("students/\(student.id)")
            .updateData(["attendance": !student.attandance])
        
        tableView.reloadData()
        
    }
    func setDateForTitle(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //formatter.dateFormat = .medium
        formatter.dateFormat = "EEEE,MM d, yyyy"
        //let resultDate = formatter.string(from: date)
       // self.navigationItem.title = resultDate
    }
}
