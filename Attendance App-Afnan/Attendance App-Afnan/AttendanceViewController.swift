//
//  AttendanceViewController.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 30/03/1443 AH.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth


struct StudentsName {
     var name: String
    var attendance: Bool
}



class AttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, checkButtondelgate, DataEnteredDelegate {
    
    var nameArray = [StudentsName]()
    var selectDate: Days?
    let tableview: UITableView = UITableView()
    let studentNameLabel: UILabel = UILabel()
    let attendanceLabel: UILabel = UILabel()
    var button:UIButton = UIButton()
    let dateFormatter: DateFormatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableview.backgroundColor = .gray
        tableview.reloadData()
        tableview.showsVerticalScrollIndicator = false
       
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(button)
        button.leftAnchor.constraint(equalTo: view.leftAnchor)
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 30)
        button.topAnchor.constraint(equalTo: view.bottomAnchor)
        button.topAnchor.constraint(equalTo: view.topAnchor)
      
        view.addSubview(studentNameLabel)
        studentNameLabel.text = "test test"
               studentNameLabel.font = .boldSystemFont(ofSize: 15)
               studentNameLabel.translatesAutoresizingMaskIntoConstraints = false
             
        NSLayoutConstraint.activate([
            studentNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            studentNameLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10),
            studentNameLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor),
                   studentNameLabel.heightAnchor.constraint(equalToConstant: 20)
               ])
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
            view.addSubview(attendanceLabel)
        attendanceLabel.textColor = .red
                attendanceLabel.font = .boldSystemFont(ofSize: 18)
                attendanceLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    attendanceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    attendanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -25)
                ])

        
        attendanceLabel.text = "student count = \(nameArray.filter({ student in student.attendance}).count)"
        
        Firestore.firestore().collection("student").addSnapshotListener {
            snapshot, error in
            if error != nil {
                print("Error\(error)")
                return
            }
            var studentArray = [StudentsName]()
            for document in snapshot!.documents{
                let value = document.data()
                let name = value["name"] as! String
                let attend = value["attend"] as! Bool
                studentArray.append(StudentsName(name: name, attendance: attend))
            }
            
            self.nameArray = studentArray
            self.tableview.reloadData()
        }
                                                                
    
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nameArray.count > 0 {
            return nameArray.count
        } else {
            return 0
        }
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! AttendanceCell
        
      //  cell.studentname.text = nameArray[indexPath.row].studentname
        if nameArray[indexPath.row].attendance {
            cell.AttendanceButton.setImage(_ImageLiteralType(named: "check"), for: .normal)
        }else {
            cell.AttendanceButton.setImage(_ImageLiteralType(named: "uncheck button"), for: .normal)
        }
            
        return cell
    }
    
  func  datePickerValueChanged(_ sender: UIDatePicker){

             // Create date formatter
            

             // Set date format
             dateFormatter.dateFormat = "EEEE, MMM d"
             // Apply date format
             let selectedDate: String = dateFormatter.string(from: sender.date)

             print("Selected value \(selectedDate)")
      studentNameLabel.text = "\(selectedDate)"
         }
    
    func checkTaskTapped(at indexpath: IndexPath) {
        if nameArray[indexpath.row].attendance {
            nameArray[indexpath.row].attendance = false
            
        } else {
            nameArray[indexpath.row].attendance = true
        }
        tableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: false)
        nameArray[indexPath.row].attendance = !nameArray[indexPath.row].attendance
        attendanceLabel.text = "student count = \(nameArray.filter({ student in student.attendance}).count)"
        tableview.reloadData()
    }
    
    var studentname: Students?
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier == "showSecondViewController" {
//               let secondViewController = segue.destination as! StudentsViewController
//            //   StudentsViewController.delgate = self
//           }
//       }

       func userDidEnterInformation(info: String) {
           studentNameLabel.text = info
       }
    
    
    }
    
