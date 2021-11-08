//
//  NewDayVC.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import UIKit
import FirebaseFirestore


class NewDayVC: UIViewController {
    
    
    
    var datePicker: UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(dateChanged), for: .touchUpInside)
        datePicker.datePickerMode = .date
        
        return datePicker
    }
    
    var addDate: UIButton {
        let dateB = UIButton()
        dateB.translatesAutoresizingMaskIntoConstraints = false
        dateB.backgroundColor = .systemMint
        dateB.titleLabel?.font = .systemFont(ofSize: 16)
        dateB.setTitle("Add Date", for: .normal)
        dateB.addTarget(self, action: #selector(addDay), for: .touchUpInside)
        
        return dateB
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view .backgroundColor = .cyan
        
        self.view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        self.view.addSubview(addDate)
        NSLayoutConstraint.activate([
            addDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addDate.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            addDate.heightAnchor.constraint(equalToConstant: 48),
            addDate.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        
        
    }
    
    @objc func dateChanged() {
        
        print("New date = \(datePicker.date)")
    }
    
    @objc func addDay() {
        let date = datePicker.date
        let uuid = UUID().uuidString
        
        DaysService.shared.addDay(
            day: Day(
                id: uuid,
                time: Timestamp(date: date),
                presentStudent: []
            )
        )
        
        dismiss(animated: true, completion: nil)
    }
}
