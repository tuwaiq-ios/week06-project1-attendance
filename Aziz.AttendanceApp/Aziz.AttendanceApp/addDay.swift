//
//  addDay.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 29/03/1443 AH.
//

import Foundation

import UIKit

class ShowButton: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var DaysText = UITextField()
    let BtnOK = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .cyan
        
        DaysText.placeholder = "Add Days"
        DaysText.textAlignment = .center
        DaysText.translatesAutoresizingMaskIntoConstraints = false
        DaysText.textColor = .black
        DaysText.font = UIFont.systemFont(ofSize: 18)
        DaysText.backgroundColor = .systemGray5
        
        view.addSubview(DaysText)
        
        NSLayoutConstraint.activate([
            DaysText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DaysText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            DaysText.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        BtnOK.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnOK)
        
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
        
//        func sendName(_ sender: Any) {
//           // let sAdd = StudentsData (StudentName: DaysText.text!, attendancelabel: true)
//            //addtoTable.append(sAdd)
//
//        }
//
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    }
    
}

