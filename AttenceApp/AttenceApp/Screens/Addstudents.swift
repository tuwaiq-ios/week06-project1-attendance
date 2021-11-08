//
// Addstudents.swift
//  attendanccc
//
//  Created by sally asiri on 28/03/1443 AH.
//



import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class AddStudentScreen: UIViewController {
    
    
    let nameOfStudentTextField = UITextField()
    let addButton = UIButton(type: .system)
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNameOfStudentTF()
        setupAddStudentButton()
    }
    

    
    private func setupNameOfStudentTF() {
        nameOfStudentTextField.backgroundColor = .systemGray6
        nameOfStudentTextField.layer.cornerRadius = 5
        nameOfStudentTextField.clipsToBounds = true
        nameOfStudentTextField.placeholder = "Student's Name"
        nameOfStudentTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        nameOfStudentTextField.leftViewMode = .always
        nameOfStudentTextField.autocorrectionType = .no
        nameOfStudentTextField.autocapitalizationType = .words
        nameOfStudentTextField.tintColor = .black
        
        
        nameOfStudentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(nameOfStudentTextField)
        
        nameOfStudentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameOfStudentTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameOfStudentTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameOfStudentTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    
    private func setupAddStudentButton() {
        
        addButton.layer.cornerRadius    = 20
        addButton.layer.borderColor     = UIColor.systemPink.cgColor
        addButton.layer.borderWidth     = 0.55
        addButton.backgroundColor       = .white
        addButton.setTitle("Add Student", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(addButton)
        
        addButton.topAnchor.constraint(equalTo: nameOfStudentTextField.bottomAnchor, constant: 20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
    @objc private func addButtonTapped() {
        
        guard let tfText = nameOfStudentTextField.text else {return}
        guard let user = Auth.auth().currentUser else {print("error sign in user"); return}
        if !tfText.isEmpty {
            
            
            db.collection("Teacher").document().setData(
                
                [
                
                    "studentName" : tfText,
                    "teacherID": user.uid
                
                ]
                
                , merge: true) { error in
                    
                    if let error = error {
                        print("Error saving data for teacher: \(error.localizedDescription)")
                        return
                    }else{
                        print("successfully added student to Teacher Collection")
                    }
                    
                }
            
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    

    
    
    
}
