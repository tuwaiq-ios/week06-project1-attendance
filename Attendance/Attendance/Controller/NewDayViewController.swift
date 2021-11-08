//
//  DateViewController.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import UIKit
import DTGradientButton
import FirebaseFirestore
class NewDayViewController: UIViewController {
    
    let selectedDay                  = UIButton()
    let datePicker: UIDatePicker     = UIDatePicker()
    let dateLabel                    = UILabel()
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
       view.addSubview(datePicker)
       NSLayoutConstraint.activate([
           datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
       ])
        
        // Set some of UIDatePicker properties
        datePicker.timeZone         = .none
        datePicker.datePickerMode   = .date
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
   
        // Add DataPicker to the view
        self.view.addSubview(datePicker)
        setupDateLabel()
        setupAddDayButton()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
   
        // Set date format
        dateFormatter.dateFormat = "EEEE, MMM d"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
        
        dateLabel.text           = "\(selectedDate)"
    }
   
    
    func setupDateLabel(){
        
        dateLabel.font = .boldSystemFont(ofSize: 40)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: 40 )
        ])
    }

    func setupAddDayButton(){
        let topColor    = UIColor(red: 245.0/255.0, green: 176.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 212.0/225.0, green: 38.0/225.0, blue: 28.0/225.0, alpha: 1.0)
        let colorsArray = [topColor, bottomColor]
        
        selectedDay.setGradientBackgroundColors(colorsArray,
                                                 direction: .toBottom,
                                                 for: .normal)
        
        selectedDay.setTitle("Add Day", for: .normal)
        selectedDay.titleLabel?.font        = .boldSystemFont(ofSize: 18)
        selectedDay.layer.masksToBounds     = true
        selectedDay.layer.cornerRadius      = 10.0
        
        selectedDay.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectedDay)
        NSLayoutConstraint.activate([
            selectedDay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            selectedDay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            selectedDay.heightAnchor.constraint(equalToConstant: 100),
            selectedDay.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        selectedDay.addTarget(self, action: #selector(selectedDayTapped), for: .touchUpInside)
   }
    
    @objc func selectedDayTapped(){
        
        // Set date format
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        // Apply date format
        let selectedDate = datePicker.date
        let uuid         = UUID().uuidString
       
        DayService.shared.addNewDay(day:Day(id: uuid,
                                            date: selectedDate,
                                            attendenc: [])
        )
        
        dismiss(animated: true)
    }
}
