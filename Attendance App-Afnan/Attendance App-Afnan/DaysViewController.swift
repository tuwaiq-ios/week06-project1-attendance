//
//  DaysViewController.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 28/03/1443 AH.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

struct Days {
   // var dayname: String
   var date: Date
    
}

var attendedStudents = [String]()
 var presented = [String]()
 var absent = [String]()

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var days = [Days]()
    let db = Firestore.firestore()
   // let date = Date()
    
    let tableview: UITableView = UITableView()
    let daybutton: UIButton = UIButton()
    var dateformatter: DateFormatter = DateFormatter()
 //   var totalStudent = Students.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        view.addSubview(daybutton)
        tableview.reloadData()
        //tableview.isHidden = false
        view.backgroundColor = .white
        tableview.backgroundColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
     
       
        //tableview.showsVerticalScrollIndicator = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        ])
//        daybutton.translatesAutoresizingMaskIntoConstraints = false
        daybutton.setTitle("Add Day", for: .normal)
        daybutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        daybutton.frame = CGRect(x: 280, y: 650, width: 100, height: 100)
        daybutton.backgroundColor = UIColor.systemMint
        
        NSLayoutConstraint.activate([
            daybutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        Firestore.firestore().collection("Date").addSnapshotListener {
            snapshot, error in
            if error != nil {
                print("Error\(String(describing:error))")
            }
            
            var dayarray = [Days]()
            for Document in snapshot!.documents {
                let value = Document.data()
                let date = (value["date"] as! Timestamp).dateValue()
                    dayarray.append(Days(date: date))
            }
            
            self.days = dayarray
            self.tableview.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableview.dequeueReusableCell(withIdentifier: "days", for: indexPath) as! DaysTableViewCell
                let data = days[indexPath.row]
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                let formatedDate = formatter.string(from: data.date)
                cell.dayLabel.text = formatedDate

                return cell
            }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let nextVC = AttendanceViewController()

               let formatter = DateFormatter()
               formatter.dateFormat = "EEEE, MMM d"
        let formatedDate = formatter.string(from: days.date)

               nextVC.title = formatedDate

               navigationController?.pushViewController(nextVC, animated: true)

    }
    
    
    
    @objc func buttonAction(sender: UIButton) {
        
        dateformatter.dateFormat = "MM/dd/yyyy hh:mm"
   //     dateformatter.string(from: date)
          let myDatePicker: UIDatePicker = UIDatePicker()
              myDatePicker.timeZone = .current
              myDatePicker.preferredDatePickerStyle = .wheels
           
            myDatePicker.frame = CGRect(x: 0, y: 25, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        
             alertController.view.addSubview(myDatePicker)
        
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in

                var ref: DocumentReference? = nil
                
                ref = self.db.collection("Date").addDocument(data: [
                        "date" : myDatePicker.date
                      ]) { err in
                        if let err = err {
                          print("Error adding document: \(err)")
                        } else {
                          print("Document added with ID: \(ref!.documentID)")
                        }
            }
        })
              let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                 alertController.addAction(selectAction)
                 alertController.addAction(cancelAction)
                 self.present(alertController, animated: true)
        
                                             }
}
