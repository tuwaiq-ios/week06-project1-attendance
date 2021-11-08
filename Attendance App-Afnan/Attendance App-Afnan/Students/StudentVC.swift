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
    
    var studentTV: UITableView {
        let Stableview = UITableView()
        Stableview.translatesAutoresizingMaskIntoConstraints = false
        Stableview.delegate = self
        Stableview.dataSource = self
        Stableview.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
        Stableview.isHidden = false
        
        
        return Stableview
    }
    
    var addStudentButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("Add Student", for: .normal)
        button.backgroundColor = .systemMint
        
        return button
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.heightAnchor.constraint(equalToConstant: 120).isActive = true

        view.addSubview(studentTV)
        NSLayoutConstraint.activate([
            studentTV.topAnchor.constraint(equalTo: view.topAnchor),
            studentTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            studentTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentTV.leftAnchor.constraint(equalTo: view.leftAnchor)
    
        ])
        
        view.addSubview(addStudentButton)
        NSLayoutConstraint.activate([
            addStudentButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            addStudentButton.heightAnchor.constraint(equalToConstant: 100),
            addStudentButton.widthAnchor.constraint(equalToConstant: 100)
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
    



}
