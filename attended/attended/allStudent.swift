//
//  date.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class AllStudentsNames: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    let tv = UITableView()
    let attendanceLabel = UILabel()
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
    var studentNewName = UITextField()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemIndigo
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
       
        view.addSubview(studentNewName)
        studentNewName.placeholder = "new Student"
        studentNewName.textAlignment = .center
        studentNewName.translatesAutoresizingMaskIntoConstraints = false
        studentNewName.textColor = .black
        studentNewName.font = UIFont.systemFont(ofSize: 15)
        studentNewName.backgroundColor = .systemGray5
        
        view.addSubview(studentNewName)
        
        NSLayoutConstraint.activate([
            studentNewName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studentNewName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            studentNewName.widthAnchor.constraint(equalToConstant: 200),
            studentNewName.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            studentNewName.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            studentNewName.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            studentNewName.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40)
        ])
//        addNewStudent.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(addNewStudent)
//
//        NSLayoutConstraint.activate([
//            addNewStudent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
//            addNewStudent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
//        ])
    }
//    var addNewStudent = UIButton()
//    addNewStudent.backgroundColor = UIColor.systemGreen
//    addNewStudent.setTitle("Add", for: .normal)
    
//    func buttonAction(sender: UIButton!) {
//
//        Firestore
//            .firestore()
//            .document("Days/Student")
//            .setData([
//
////                    "id" : 1,
//                "name" : studentNewName,
//                "attendance" : true
//            ])
//    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
      //  let student = students [indexPath.row]
     //  cell.backgroundColor = .green
      cell.textLabel?.text = students[indexPath.row].name
        
//        if student.attendance{
           cell.backgroundColor = .systemMint
//        }else{
//            cell.backgroundColor = .lightGray
//        }
       return cell
        
//    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        students[indexPath.row].attendance = !students[indexPath.row].attendance
//
//
////      ttendance }).count)"
//        tableView.reloadData()
//    }

    
    }
}
