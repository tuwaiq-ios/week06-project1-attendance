//
//  File.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit

class showButton: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var StudentsText = UITextField()
    let BtnOK = UIButton()
    
    
    var callbackClosure: (() -> Void)?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        callbackClosure?()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .cyan
        
        StudentsText.placeholder = "Add Student"
        StudentsText.textAlignment = .center
        StudentsText.translatesAutoresizingMaskIntoConstraints = false
        StudentsText.textColor = .black
        StudentsText.font = UIFont.systemFont(ofSize: 18)
        StudentsText.backgroundColor = .systemGray5
        
        view.addSubview(StudentsText)
        
        NSLayoutConstraint.activate([
            StudentsText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            StudentsText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            StudentsText.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        BtnOK.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(BtnOK)
        
        BtnOK.addTarget(self, action: #selector (sendName), for: .touchUpInside)
        NSLayoutConstraint.activate([
            //            BtnOK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //             BtnOK.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //        BtnOK.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            BtnOK.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -180),
            //        BtnOK.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        BtnOK.backgroundColor = UIColor.red
        BtnOK.setTitle("OK", for: .normal)
        
        func buttonAction(sender: UIButton!) {
            
            let btnsendtag: UIButton = sender
            if btnsendtag.tag == 1 {
                
                dismiss(animated: true, completion: nil)
            }
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    }
    
    @objc func sendName(sender: UIButton!) {
        
        //let sAdd = StudentsData (StudentName: StudentsText.text!)
        addtoTable.append(StudentsData(StudentName : StudentsText.text!))
        dismiss(animated: true)
    }
}
