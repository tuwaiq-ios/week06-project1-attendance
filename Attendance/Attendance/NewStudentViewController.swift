//
//  NewStudentViewController.swift
//  Attendance
//
//  Created by Eth Os on 01/04/1443 AH.
//

import UIKit
import DTGradientButton
import FirebaseFirestore

class NewStudentViewController: UIViewController {

    let addStudent = UIButton()
    let gradientLayer = CAGradientLayer()
    let idTextField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .default
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Student ID ... "
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    let nameTextField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .default
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Student Name ... "
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupAddStudentButton()
        setupFields()
    }
    
    func setupFields(){
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(idTextField)
        NSLayoutConstraint.activate([
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.topAnchor.constraint(equalTo: view.topAnchor,constant: 200),
            idTextField.heightAnchor.constraint(equalToConstant: 70),
            idTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        idTextField.resignFirstResponder()
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 70),
            nameTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        nameTextField.resignFirstResponder()
    }
    
    func setupAddStudentButton(){
        let topColor = UIColor(red: 120.0/255.0, green: 148.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 42.0/255.0, green: 74.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        let colorsArray = [topColor, bottomColor]
        addStudent.setGradientBackgroundColors(colorsArray,
                                                 direction: .toBottom,
                                                 for: .normal)
        addStudent.setTitle("Add", for: .normal)
        addStudent.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addStudent.layer.masksToBounds = true
        addStudent.layer.cornerRadius = 10.0
        addStudent.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addStudent)
        NSLayoutConstraint.activate([
            addStudent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStudent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            addStudent.heightAnchor.constraint(equalToConstant: 100),
            addStudent.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addStudent.addTarget(self, action: #selector(addStudentTapped), for: .touchUpInside)
    }
    
    @objc func addStudentTapped(){
        
        let  newStudent = Student(id: idTextField.text ?? "0",
                                  studentName: nameTextField.text ?? "")
        
        
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("students").addDocument(data: [
            "id": newStudent.id,
            "name": newStudent.studentName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        idTextField.text = ""
        nameTextField.text = ""
        students.append(newStudent)
        print(students)
    }
}
