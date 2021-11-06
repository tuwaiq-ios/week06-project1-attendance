//
//  StudentsVC.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//

import Foundation
import FirebaseFirestore
import UIKit

    class studentsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
        var studentday : Days?
    let tv = UITableView()
        var attendanceLabel = UILabel()
    var students = [
        Student(name: "1- tasnim", attendance: true),
        Student(name: "2- sara", attendance: true),
        Student(name: "3- Reem", attendance: true),
        Student(name: "4- Ranim", attendance: true),
        Student(name: "5- eveleen", attendance: true),
        Student(name: "6- samar", attendance: true),
        Student(name: "7- fatemah", attendance: true),
        Student(name: "8- dalal", attendance: true),
        Student(name: "9- nora", attendance: true),
        Student(name: "10- maryam", attendance: true),
        Student(name: "11- yara", attendance: true)
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         title = "Students Name : 👩🏻‍💻"
        
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .cyan
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.topAnchor),
            tv.bottomAnchor.constraint(equalTo:view.bottomAnchor),
            tv.leftAnchor.constraint(equalTo: view.leftAnchor),
            tv.rightAnchor.constraint(equalTo: view.rightAnchor),

            ])
      
        view.addSubview(attendanceLabel)
        attendanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attendanceLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:90),
            attendanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            attendanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        Firestore.firestore().collection("Student").addSnapshotListener {
            snapshot,error in
            if error != nil {
                print (error)
                return
            }
            var studentsArray = [Student]()
            for document in snapshot!.documents{
                let data = document.data()
                studentsArray.append(
                   Student(
                    name: data["name"]as! String,
                   attendance: data["attendance"]as! Bool)
                )
            }
            self.students = studentsArray
            self.tv.reloadData()
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let student = students [indexPath.row]
        cell.backgroundColor = .green
        cell.textLabel?.text = students[indexPath.row].name
        
        if student.attendance{
            cell.backgroundColor = .systemMint
        }else{
            cell.backgroundColor = .lightGray
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        students[indexPath.row].attendance = !students[indexPath.row].attendance
        
        
        attendanceLabel.text = "students.count = \(students.filter ({student in student.attendance }).count)"
        tableView.reloadData()
    }
}


