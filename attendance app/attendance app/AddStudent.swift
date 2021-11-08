//
//  AddStudent.swift
//  attendance app
//
//  Created by Ahmed Assiri on 04/04/1443 AH.
//

import UIKit

class NewStudentVC: UIViewController, UITextFieldDelegate {
    
    lazy var studentNameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Write student name"
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        view.addSubview(studentNameTF)
        NSLayoutConstraint.activate([
            studentNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studentNameTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            studentNameTF.heightAnchor.constraint(equalToConstant: 48),
            studentNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = studentNameTF.text ?? ""
        let uuid = UUID().uuidString

        StudentsService.shared.addStudent(
            student: Student(name: name, id: uuid)
        )
        
        dismiss(animated: true, completion: nil)
        return true
    }
    
}
