//
//  DatePicer.swift
//  attendace
//
//  Created by Macbook on 30/03/1443 AH.
//

import UIKit
import FirebaseFirestore
import Firebase

class DatePicer: UIViewController {
    
    var birthDateTxt = UITextField()
    //    let datePicker = UIDatePicker()
    let BtnOK = UIButton()
    
    
    let selectedDay = UIButton()
    let datePicker: UIDatePicker = UIDatePicker()
    let dateLabel = UILabel()
    let dateFormatter: DateFormatter = DateFormatter()
    
    var callbackClosure1: (() -> Void)?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        callbackClosure1?()
    }
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        createDatePicker()
        
        
        
        
        view.backgroundColor = .black
        birthDateTxt.placeholder = "Date of today"
        birthDateTxt.textAlignment = .center
        birthDateTxt.translatesAutoresizingMaskIntoConstraints = false
        birthDateTxt.textColor = .black
        birthDateTxt.font = UIFont.systemFont(ofSize: 18)
        birthDateTxt.backgroundColor = .systemGray5
        
        view.addSubview(birthDateTxt)
        
        NSLayoutConstraint.activate([
            birthDateTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthDateTxt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            birthDateTxt.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        BtnOK.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnOK)
        
        NSLayoutConstraint.activate([
            //            BtnOK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //             BtnOK.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //        BtnOK.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            BtnOK.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -170),
            //        BtnOK.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        BtnOK.backgroundColor = UIColor.gray
        BtnOK.setTitle("DONE", for: .normal)
        BtnOK.addTarget(self, action: #selector(butunp), for: .touchUpInside)
        func buttonAction(sender: UIButton!) {
            let btnsendtag: UIButton = sender
            if btnsendtag.tag == 1 {
                
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func createDatePicker(){
        
        birthDateTxt.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (donePressed))
        toolbar.setItems ([doneBtn], animated: true)
        
        birthDateTxt.inputAccessoryView = toolbar
        
        datePicker.preferredDatePickerStyle = .wheels
        birthDateTxt.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed(_ sender: UIDatePicker) {
        
        //        let formatter = DateFormatter()
        //        formatter.dateStyle = .medium
        //        formatter.timeStyle = .none
        //
        //
        //        birthDateTxt.text = formatter.string(from: datePicker.date)
        
        dateFormatter.dateFormat = "EEEE, MMM d"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.view.endEditing(true)
        
        birthDateTxt.text = "\(selectedDate)"
        //
        //        dateP.append(
        //            Day(date: datePicker.date)
        //        )
        
        
        
        //dismiss(animated: true)
    }
    
    @objc func butunp(){
        //        let now = Date()
        //        let stamp = Timestamp(date: now)
        dateFormatter.dateFormat = "EEEE, MMM d"
        // Apply date format
        
        let selectedDate = datePicker.date
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("Days").addDocument(data: [
            "Date": selectedDate,
            // "attendence": students
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        dismiss(animated: true)
    }
    
}



