//
//  Attendance
//
//  Created by Fawaz on 06/11/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

//============================================================================
class StudentPage: UIViewController {
  
  var addstudentTxt = UITextField()
  let datePicker = UIDatePicker()
  let BtnOK = UIButton()
  var callbackClosure: (() -> Void)?
  //==========================================================================
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    callbackClosure?()
  }
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
    
    BtnOK.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
    
    BtnOK.backgroundColor = UIColor.orange
    BtnOK.setTitle("OK", for: .normal)
    
    NSLayoutConstraint.activate([
      BtnOK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
      
      BtnOK.heightAnchor.constraint(equalToConstant: 50),
      BtnOK.widthAnchor.constraint(equalToConstant: 300)
    ])
    //========================================================================
    func buttonAction(sender: UIButton!) {
      
      let btnsendtag: UIButton = sender
      
      if btnsendtag.tag == 1 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  //==========================================================================
  func createDatePicker(){
    addstudentTxt.textAlignment = .center
      datePicker.datePickerMode = .date
  }
  //==========================================================================
  @objc func donePressed() {
    
    guard let add = addstudentTxt.text  else {return}
    
    Firestore
      .firestore()
      .collection("students")
      .addDocument(data:[
        
        "name" : add,
        "attendance" : true
    ])
    addstudentTxt.text = ""
    dismiss(animated: true)
  }
} // class end
//==========================================================================
