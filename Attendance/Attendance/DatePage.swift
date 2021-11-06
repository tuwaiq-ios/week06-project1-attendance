//
//  Attendance
//
//  Created by Fawaz on 04/11/2021.
//

import UIKit

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
    
    daySelectOKButton.setTitle("OK", for: .normal)
    daySelectOKButton.backgroundColor = UIColor.blue
    daySelectOKButton.addTarget(self, action: #selector(butunp), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      daySelectOKButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      daySelectOKButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
      
      daySelectOKButton.heightAnchor.constraint(equalToConstant: 50),
      daySelectOKButton.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  //==========================================================================
  func createDatePicker(){
    
    enterDateTextF.textAlignment = .center
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                  target: nil,
                                  action: #selector (donePressed))
    toolbar.setItems ([doneBtn], animated: true)
    
    enterDateTextF.inputAccessoryView = toolbar
    
    datePicker.preferredDatePickerStyle = .wheels
    enterDateTextF.inputView = datePicker
    datePicker.datePickerMode = .date
  }
  //==========================================================================
  override func viewDidLoad(){
    super.viewDidLoad()
    
    birthDateTxt_func()
    daySelectOKButton_func()
    createDatePicker()
    
    view.backgroundColor = .white
    
    func buttonAction(sender: UIButton!) {
      
      let btnsendtag: UIButton = sender
      if btnsendtag.tag == 1 {
        dismiss(animated: true, completion: nil)
      }
    }
  }
  //==========================================================================
  @objc func donePressed() {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    enterDateTextF.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
    
    dateP.append(Day(date: datePicker.date))
  }
  //==========================================================================
  @objc func butunp() {
    dismiss(animated: true)
  }
  //==========================================================================

} //class end
