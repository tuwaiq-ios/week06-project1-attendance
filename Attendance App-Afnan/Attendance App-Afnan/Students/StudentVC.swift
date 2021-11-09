//
//  StudentVC.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import Foundation
import UIKit
import Firebase


class StudentsVC: UIViewController {
    
    var students = [Student]()
    
    lazy var studentTV: UITableView  = {
        let Stableview = UITableView()
        Stableview.translatesAutoresizingMaskIntoConstraints = false
        Stableview.delegate = self
        Stableview.dataSource = self
        Stableview.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
        
        return Stableview
    }()
    
    lazy var addStudentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("Add Student", for: .normal)
        button.backgroundColor = .systemMint
        button.sizeToFit()
    
        return button
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.heightAnchor.constraint(equalToConstant: 120).isActive = true


        view.addSubview(studentTV)
        view.addSubview(addStudentButton)

        NSLayoutConstraint.activate([
            studentTV.topAnchor.constraint(equalTo: view.topAnchor),
            studentTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            studentTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentTV.leftAnchor.constraint(equalTo: view.leftAnchor)

        ])
        
        NSLayoutConstraint.activate([
            addStudentButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            addStudentButton.heightAnchor.constraint(equalToConstant: 100),
            addStudentButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        StudentsService.shared.listenToStudents { newStudents in
            self.students = newStudents
            self.studentTV.reloadData()
        }
     
    }

  @objc  func buttonAction() {
      
       let newStudent = NewStudentVC()
      present(newStudent.self, animated: true, completion: nil)
    }
    
}


extension StudentsVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let students = students[indexPath.row]
        cell.textLabel?.text = students.name
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        let cell = students[indexPath.row]
        let alertcontroller = UIAlertController(title: "Alert"
                                                , message: "Are you sure you want to delete all the tasks?"
                                                , preferredStyle: UIAlertController.Style.alert
        )
        
              alertcontroller.addAction(
                      UIAlertAction(title: "cancel",
                                    style: UIAlertAction.Style.default,
                                    handler: { Action in print("...")
            })
            
        )
        
        alertcontroller.addAction(
            UIAlertAction(title: "Delete",
                          style: UIAlertAction.Style.destructive,
                          handler: { Action in
                if editingStyle == .delete {
                    self.students.remove(at: indexPath.row)
                    self.studentTV.deleteRows(at: [indexPath], with: .fade)
                }
                self.studentTV.reloadData()
            })
            
        )
        
        self.present(alertcontroller, animated: true, completion: nil)
    
    }
}
