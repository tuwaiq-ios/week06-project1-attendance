//
//  ViewController.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore

struct Students{
    var name : String?
    var iScompletd = false
}
var names = [Students]()

class StudentsName: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    let db = Firestore.firestore()
    var tableView: UITableView  =   UITableView()
    let tf =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let  namelabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableAndView()
        getDataFromFirebase()
    }
    // this func to get all data from firebase
    func getDataFromFirebase () {
        Firestore.firestore().collection("users").addSnapshotListener {
            snapshot, error in
            if error != nil {
                print(error as Any)
            }
            for document in snapshot!.documents {
                let data = document.data()
                let name = data["name"] as! String?
                names.append(Students(name: name, iScompletd: false))
            }
            
            self.tableView.reloadData()
        }
    }
    
    func setTableAndView() {
        self.view.addSubview(tableView)
        self.view.addSubview( tf)
        self.view.addSubview(namelabel)
        
        tableView.backgroundColor = .white
        view.backgroundColor = .systemCyan
        
        tf.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tf.placeholder = "Enter text here"
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.center = CGPoint(x:160, y: 110)
        
        namelabel.center = CGPoint(x: 120, y: 70)
        namelabel.font = UIFont.systemFont(ofSize: 20)
        namelabel.textColor = .black
        namelabel.textAlignment = .left
        namelabel.text = "Students Name..."
        
        let image = UIImage(named: "add_new_post_btn")
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 270, y: 50, width: 200, height: 100)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if tf.text?.isEmpty ?? false {
            // Enter you name
            return
        }
        if tf.hasText {
            let newStudent = Students(name: tf.text, iScompletd: false)
            names.insert(newStudent , at: 0)
            
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: [
                "name" : tf.text ?? ""
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        tf.text = " "
        tf.resignFirstResponder()
        tableView.reloadData()
        let alertController = UIAlertController(title: "Data saved", message: "The name of student you add has been saved 😃", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = names[indexPath.row].name
        
        return cell
        
    }
    func tableView(_ tableView:UITableView, commit edititingStyle:UITableViewCell.EditingStyle , forRowAt indexPath: IndexPath){
        let alertcontroller = UIAlertController(title: "Alert"
                                                , message: "Are you sure you want to delete this person?"
                                                , preferredStyle: UIAlertController.Style.alert
        )
        alertcontroller.addAction(
            UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { Action in print("...")
            })
        )
        alertcontroller.addAction(
            UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { Action in
                if edititingStyle == .delete{
                    names.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
                self.tableView.reloadData()
            })
        )
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
}

