//
//  ViewController.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 28/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct Students {
     var name: String
     //var attendance = false
}

// Protocol used for sending data back
protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(info: String)
}

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: DataEnteredDelegate? = nil
    
    var students = [Students]()

    var tableview: UITableView = UITableView()

    let addStudentButton: UIButton = UIButton()
    
    let addTextField: UITextField = UITextField(frame: CGRect(x: 20, y: 150, width: 300, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(tableview)
        view.addSubview(addTextField)
        view.addSubview(addStudentButton)
        
//        static let identifer = "studentsCell"

        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "studentsCell")
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        ])
        
        addTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    
        addTextField.textAlignment = .center
        addTextField.textColor = .black
        addTextField.backgroundColor = .lightGray
        addTextField.placeholder = "New Studant Name..."
        
    NSLayoutConstraint.activate([
        addTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
        addTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        addTextField.leftAnchor.constraint(equalTo: view.leftAnchor),
        addTextField.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        let image = UIImage(systemName: "person.crop.circle.badge.plus")
            let addStudent = UIButton(type: UIButton.ButtonType.custom)
            addStudentButton.frame = CGRect(x: 250, y: 120, width: 250, height: 100)
            addStudentButton.setImage(image, for: .normal)
        addStudentButton.addTarget(self, action: #selector(buttonbressd), for: .touchUpInside)
            
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if students.count > 0 {
            return students.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "studentsCell", for: indexPath)
        cell.textLabel?.text = students[indexPath.row].name
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        let cell = students[indexPath.row]
        
        let alertcontroller = UIAlertController(title: "Alert"
                                                , message: "Are you sure you want to delete all the name?"
                                                , preferredStyle: UIAlertController.Style.alert
        )
        
        alertcontroller.addAction(
            UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { Action in print("...")
            })
            
        )
        
        alertcontroller.addAction(
            UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { Action in
                if editingStyle == .delete {
                    self.students.remove(at: indexPath.row)
                    self.tableview.deleteRows(at: [indexPath], with: .fade)
                }
                self.tableview.reloadData()
            })
            
        )
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
    let db = Firestore.firestore()
    
   @objc func buttonbressd(_ sender: Any) {
            if addTextField.hasText {
                let newName = Students(name: addTextField.text!)
            students.insert(newName, at: 0)
                tableview.reloadData()
            }
    
        addTextField.text = " "
        addTextField.resignFirstResponder()
    
       var ref: DocumentReference? = nil
             ref = db.collection("Students").addDocument(data: [
               "Student Name" : addTextField.text ?? " "
             ]) { err in
               if let err = err {
                 print("Error adding document: \(err)")
               } else {
                 print("Document added with ID: \(ref!.documentID)")
               }
       
    }
    }
    
    func sendTextBackButton(sender: AnyObject) {
        
            // Call this method on whichever class implements our delegate protocol
            delegate?.userDidEnterInformation(info: addTextField.text!)

            // Go back to the previous view controller
            _ = self.navigationController?.popViewController(animated: true)
        }
    
}
