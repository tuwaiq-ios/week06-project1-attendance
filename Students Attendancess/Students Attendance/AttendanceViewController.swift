//
//  AttendanceViewController.swift
//  Students Attendance
//
//  Created by PC on 05/04/1443 AH.
//

import UIKit
import Firebase

struct Attendance {
    var id : String?
    var name : String?
    var status : Bool?
    var timestamp : String?
}

class AttendanceViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var selectedDay : Day?
    var presentCount = 0
    var absentCount = 0
    
    var attendanceArray : [Attendance] = [] {didSet {attendanceArray = attendanceArray.sorted(by: {$0.timestamp! > $1.timestamp!})}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAttendance()
        
        
        if let day = selectedDay?.day {
        navigationItem.title = day
        }
        
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
        
        studentsTableView.reloadData()
        
        absentLabel.text = "A : \(absentCount)"
        presentLabel.text = "P : \(presentCount)"
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
        Firestore.firestore().collection("Days").document(selectedDay!.day!).addSnapshotListener { snapshot, error in
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
        return attendanceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = attendanceArray[indexPath.row].name
        cell.selectionStyle = .none
        if attendanceArray[indexPath.row].status == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType != .checkmark {

            Firestore.firestore().collection("Days").document(selectedDay!.day!).updateData([self.attendanceArray[indexPath.row].id : [
                "name" : self.attendanceArray[indexPath.row].name!,
                "status" : true,
                "timestamp" : self.attendanceArray[indexPath.row].timestamp!
            ]])
            cell?.accessoryType = .checkmark
            }
        }
    }


extension AttendanceViewController {
    func getAttendance() {
        Firestore.firestore().collection("Days").document(selectedDay!.day!).addSnapshotListener { document, error in
            self.absentCount = 0
            self.presentCount = 0
            self.attendanceArray.removeAll()
            if error == nil {
                if let value = document?.data() {
                    let keys = Array(value.keys)
                    for (index, i) in value.values.enumerated() {
                        if let valueData = i as? [String : Any] {
                            if let name = valueData["name"] as? String, let status = valueData["status"] as? Bool, let timestamp = valueData["timestamp"] as? String {
                                self.attendanceArray.append(Attendance(id: keys[index], name: name, status: status, timestamp: timestamp))
                                
                                if status == false {
                                    self.absentCount += 1
                                } else {
                                    self.presentCount += 1
                                }
                            }
                        }
                    }
                    
                    self.absentLabel.text = "A : \(self.absentCount)"
                    self.presentLabel.text = "P : \(self.presentCount)"
                    
                    self.studentsTableView.reloadData()
                }
            }
        }
    }
}
