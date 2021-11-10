//
//  ViewController.swift
//  Students Attendance
//
// Created by PC on 05/04/1443 AH..
//

import UIKit
import Firebase

struct Student {
    var id : String?
    var name : String?
    var status : Bool = false
}

class StudentsViewController: UITableViewController {
    
    static var students = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let addStudentButton = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(addNewStudentAction))
        navigationItem.rightBarButtonItem = addStudentButton
        
        getStudents()
        
        
    }
    
    func getStudents() {
        
        Firestore.firestore().collection("Students").addSnapshotListener { snapshot, error in
            StudentsViewController.students.removeAll()
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    StudentsViewController.students.append(Student(id: data["id"] as? String, name: data["name"] as? String))
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR")
            }
        }
    }
    
    @objc func addNewStudentAction() {
        let alert = UIAlertController(title: "New Student", message: "", preferredStyle: .alert )
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            guard  let text = textField.text, !text.isEmpty else {
                return
            }
            
            self.addnewStudent(name: textField.text!)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Student Name ..."
            textField.textColor = .blue
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
    }

    
    func addnewStudent(name : String) {
        let studentId = String(Date().timeIntervalSince1970)
        Firestore.firestore().document("Students/\(studentId)").setData([
            "name" : name,
            "id" : studentId
        ])
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsViewController.students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = StudentsViewController.students[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }

}

