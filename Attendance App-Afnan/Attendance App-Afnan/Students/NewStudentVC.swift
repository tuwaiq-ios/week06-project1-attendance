//
//  NewStudentVC.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import UIKit

class NewStudentVC: UIViewController, UITextFieldDelegate{
    
    
    var studentNameTF: UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Write Student Name"
        tf.backgroundColor = .systemMint
        tf.delegate = self
        return tf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(studentNameTF)
        NSLayoutConstraint.activate([
            studentNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studentNameTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            studentNameTF.heightAnchor.constraint(equalToConstant: 40),
            studentNameTF.widthAnchor.constraint(equalToConstant: -40)
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
