//
//  ViewController.swift
//  attendance
//
//  Created by Hassan Yahya on 28/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

class DatePicer: UIViewController {
	
	var birthDateTxt = UITextField()
	let datePicker = UIDatePicker()
	let BtnOK = UIButton()
	
	
	var callbackClosure: (() -> Void)?
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		callbackClosure?()
	}
	
	
	
	override func viewDidLoad(){
		super.viewDidLoad()
		
		createDatePicker()
		
		
		
		
		view.backgroundColor = .darkGray
		birthDateTxt.placeholder = "Write Students Name"
		birthDateTxt.textAlignment = .center
		birthDateTxt.translatesAutoresizingMaskIntoConstraints = false
		birthDateTxt.textColor = .darkGray
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
	 
			BtnOK.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -180),
	
			BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
		])
		BtnOK.backgroundColor = UIColor.gray
		BtnOK.setTitle("OK", for: .normal)
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
	
	@objc func donePressed() {
		
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		
		birthDateTxt.text = formatter.string(from: datePicker.date)
		self.view.endEditing(true)
		
	
		
	}
	
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
	
}


