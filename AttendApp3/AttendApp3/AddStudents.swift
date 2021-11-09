//
//  AddStudents.swift
//  AttendApp3
//
//  Created by Ahmed Assiri on 04/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddStudent: UIViewController , UITextFieldDelegate{
    
    var addstudentTxt = UITextField()
    let datePicker = UIDatePicker()
    let BtnOK = UIButton()
    

    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        createDatePicker()
        
        
        
        
        view.backgroundColor = .black
        addstudentTxt.placeholder = "Add Student"
        addstudentTxt.textAlignment = .center
        addstudentTxt.translatesAutoresizingMaskIntoConstraints = false
        addstudentTxt.textColor = .black
        addstudentTxt.font = UIFont.systemFont(ofSize: 18)
        addstudentTxt.backgroundColor = .systemGray5
        
        view.addSubview(addstudentTxt)
        
        NSLayoutConstraint.activate([
            addstudentTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addstudentTxt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addstudentTxt.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        BtnOK.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnOK)
        BtnOK.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            BtnOK.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -170),

            BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        BtnOK.backgroundColor = UIColor.gray
        BtnOK.setTitle("DONE", for: .normal)
        
        func buttonAction(sender: UIButton!) {
            let btnsendtag: UIButton = sender
            if btnsendtag.tag == 1 {
                
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func createDatePicker(){
        
    }
    
    @objc func donePressed() {
        

        
        let name =  addstudentTxt.text ?? ""
        let uuid = UUID().uuidString

        StudentsService.shared.addStudent(
            student: Students(name: name, id: uuid)
        )
        
        dismiss(animated: true, completion: nil)
        
        
        
          }
    
}



