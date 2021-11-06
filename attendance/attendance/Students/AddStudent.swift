//
//  AddStudentScreen.swift
//  attendance
//
//  Created by ibrahim asiri on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class AddStudent: UIViewController {
    
    let nameStudentTF = UITextField()
    let addButton = UIButton()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        setupNameStudentTF()
        setupAddStudentBtn()
    }
    
    private func setupNameStudentTF() {
        nameStudentTF.backgroundColor = .systemGray6
        nameStudentTF.layer.cornerRadius = 5
        nameStudentTF.clipsToBounds = true
        nameStudentTF.placeholder = "اسم الطالب"
        nameStudentTF.textAlignment = .right
        nameStudentTF.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        nameStudentTF.rightViewMode = .always
        nameStudentTF.autocorrectionType = .no
        nameStudentTF.autocapitalizationType = .words
        nameStudentTF.tintColor = .black
        nameStudentTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameStudentTF)
        nameStudentTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameStudentTF.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameStudentTF.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameStudentTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    private func setupAddStudentBtn() {
        
        addButton.layer.cornerRadius    = 20
        addButton.layer.borderColor     = UIColor.black.cgColor
        addButton.layer.borderWidth     = 0.55
        addButton.backgroundColor       = .white
        addButton.setTitle("أضف طالب", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: nameStudentTF.bottomAnchor, constant: 20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc private func addBtnTapped() {
        
        guard let tfText = nameStudentTF.text else {return}
        guard let user = Auth.auth().currentUser else {print("error sign in user"); return}
        if !tfText.isEmpty {
            
            db.collection("Teacher").document().setData([
                    "studentName" : tfText,
                    "teacherID": user.uid
                ] , merge: true) { error in
                    
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
