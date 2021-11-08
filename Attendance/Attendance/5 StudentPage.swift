//
//  File6.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
import Firebase
import FirebaseFirestore
//==========================================================================
class AddStudent: UIViewController, UITextFieldDelegate {
  
  var addstudentTxt = UITextField()
  let datePicker = UIDatePicker()
  let BtnOK = UIButton()
  //==========================================================================
  override func viewDidLoad(){
    super.viewDidLoad()
    
    createDatePicker()
    
    view.backgroundColor = .white
    
    view.addSubview(addstudentTxt)
    addstudentTxt.translatesAutoresizingMaskIntoConstraints = false
    
    addstudentTxt.placeholder = "Add Student"
    addstudentTxt.textAlignment = .center
    
    addstudentTxt.textColor = .black
    addstudentTxt.font = UIFont.systemFont(ofSize: 18)
    addstudentTxt.backgroundColor = .systemGray5
    
    NSLayoutConstraint.activate([
      
      addstudentTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      addstudentTxt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      addstudentTxt.widthAnchor.constraint(equalToConstant: 300)
    ])
    view.addSubview(BtnOK)
    BtnOK.translatesAutoresizingMaskIntoConstraints = false
    
    BtnOK.backgroundColor = UIColor.orange
    BtnOK.setTitle("OK", for: .normal)
    
    BtnOK.addTarget(self,
                    action: #selector(donePressed),
                    for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      BtnOK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
      
      BtnOK.heightAnchor.constraint(equalToConstant: 50),
      BtnOK.widthAnchor.constraint(equalToConstant: 300)
    ])
    
    func buttonAction(sender: UIButton!) {
      
      let btnsendtag: UIButton = sender
      
      if btnsendtag.tag == 1 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  //==========================================================================
  func createDatePicker(){
  }
  //==========================================================================
  @objc func donePressed() {
    
    let name =  addstudentTxt.text ?? ""
    let uuid = UUID().uuidString
    
    StudentsService.shared.addStudent(
      student: Students(name: name, id: uuid)
    )
    dismiss(animated: true, completion: nil)
  }
  //==========================================================================
} //class end



