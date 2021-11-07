//
//  AttendanceViewController.swift
//  Students Attendance
//
//  Created by PC on 01/04/1443 AH.
//

import UIKit
import Firebase



class AttendanceViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var selectedDay = String()
    var presentCount = 0
    var absentCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedDay
        
        view.addSubview(attendanceStckView)
        
        attendanceStckView.addArrangedSubview(presentLabel)
        attendanceStckView.addArrangedSubview(absentLabel)
        view.addSubview(studentsTableView)
        
        NSLayoutConstraint.activate([
        
            attendanceStckView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            attendanceStckView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            attendanceStckView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            attendanceStckView.heightAnchor.constraint(equalToConstant: 50),
            
            studentsTableView.topAnchor.constraint(equalTo: attendanceStckView.bottomAnchor),
            studentsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            studentsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
//        for i in StudentsViewController.students {
//            self.attendanceArray.append(StudentsViewController.students(name: i.name, status: false))
//        }
        studentsTableView.reloadData()
        
        absentCount = StudentsViewController.students.count
        absentLabel.text = "A : \(absentCount)"
        presentLabel.text = "P : \(presentCount)"
        getPresentsCount()
    }
    
    
    let attendanceStckView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let presentLabel : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        return $0
    }(UILabel())
    
    let absentLabel : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        return $0
    }(UILabel())
    
    lazy var studentsTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return $0
    }(UITableView())
    
    
    func getPresentsCount() {
        Firestore.firestore().collection("Days").document(selectedDay).addSnapshotListener { snapshot, error in
            if error == nil {
                if let value = snapshot?.data() {
                    for (i, _) in value.enumerated() {
                        self.presentCount = i + 1
                        self.absentCount -= (i)
                    }
                    
                    self.presentLabel.text = String("P : \(self.presentCount)")
                    self.absentLabel.text = String("A : \(StudentsViewController.students.count - self.presentCount)")
                }
            } else {
                print("ERROR")
            }
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsViewController.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = StudentsViewController.students[indexPath.row].name
        cell.selectionStyle = .none
        if StudentsViewController.students[indexPath.row].status == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType != .checkmark {
            let studentId = String(Int(Date().timeIntervalSince1970))
            
            Firestore.firestore().collection("Days").document(selectedDay).updateData([studentId : [
                "name" : StudentsViewController.students[indexPath.row].name!,
                "status" : true
            ]]) { err in
                if err == nil {
                    StudentsViewController.students[indexPath.row].status = true
                    cell?.accessoryType = .checkmark
                }
            }
        }
    }
}
