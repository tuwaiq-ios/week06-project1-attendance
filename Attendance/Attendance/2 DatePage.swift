//
//  File4.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
import Firebase
import FirebaseFirestore
//==========================================================================
class DatePage: UIViewController {
  
  var enterDateTextF = UITextField()
  let datePicker = UIDatePicker()
  let daySelectOKButton = UIButton()
  var callbackClosure: (() -> Void)?
  
  //==========================================================================
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    callbackClosure?()
  }
  //==========================================================================
  func birthDateTxt_func() {
    
    view.addSubview(enterDateTextF)
    enterDateTextF.translatesAutoresizingMaskIntoConstraints = false
    
    enterDateTextF.placeholder = "Date"
    enterDateTextF.textAlignment = .center
    enterDateTextF.textColor = .black
    enterDateTextF.font = UIFont.systemFont(ofSize: 18)
    enterDateTextF.backgroundColor = .systemGray5
    
    NSLayoutConstraint.activate([
      enterDateTextF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      enterDateTextF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      enterDateTextF.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  //==========================================================================
  func daySelectOKButton_func() {
    
    view.addSubview(daySelectOKButton)
    daySelectOKButton.translatesAutoresizingMaskIntoConstraints = false
    
    daySelectOKButton.backgroundColor = .systemBlue
    daySelectOKButton.setTitle("OK", for: .normal)
    
    daySelectOKButton.addTarget(self,
                                action: #selector(butunp),
                                for: .touchUpInside)
    
    func buttonAction(sender: UIButton!) {
      
      let btnsendtag: UIButton = sender
      
      if btnsendtag.tag == 1 {
        
        dismiss(animated: true, completion: nil)
      }
    }
    NSLayoutConstraint.activate([
      daySelectOKButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      daySelectOKButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),

      daySelectOKButton.heightAnchor.constraint(equalToConstant: 50),
      daySelectOKButton.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  //==========================================================================
  override func viewDidLoad(){
    super.viewDidLoad()
    
    createDatePicker()
    birthDateTxt_func()
    daySelectOKButton_func()
    
    view.backgroundColor = .white
  }
  //==========================================================================
  func createDatePicker(){
    
    enterDateTextF.textAlignment = .center
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (donePressed))
    
    toolbar.setItems ([doneBtn], animated: true)
    
    enterDateTextF.inputAccessoryView = toolbar
    
    datePicker.preferredDatePickerStyle = .wheels
    enterDateTextF.inputView = datePicker
    datePicker.datePickerMode = .date
  }
  //==========================================================================
  @objc func donePressed() {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    enterDateTextF.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }
  //==========================================================================
  @objc func butunp(){
    
    let date = datePicker.date
    let uuid = UUID().uuidString
    
    DaysService.shared.addDay(
      
      day: Day(
        timestamp: Timestamp(date: date),
        pStudents: [],
        id: uuid
      )
    )
    dismiss(animated: true, completion: nil)
  }
  //==========================================================================
} //class end


