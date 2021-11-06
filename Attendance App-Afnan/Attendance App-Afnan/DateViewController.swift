////
////  DateViewController.swift
////  Attendance App-Afnan
////
////  Created by Fno Khalid on 28/03/1443 AH.
////
//
//import UIKit
//
//class DateViewController: UIViewController {
//    
//    let datePicker: UIDatePicker = UIDatePicker()
//    
//    var addDateButton: UIButton = UIButton()
//
//    
//    // Posiiton date picket within a view
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.addSubview(datePicker)
//        self.view.addSubview(addDateButton)
//        
//        datePicker.frame = CGRect(x: -90, y: 50, width: self.view.frame.width, height: 300)
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.backgroundColor = UIColor.white
//        datePicker.addTarget(self, action: #selector(DateViewController.datePickerValueChanged(_:)), for: .valueChanged)
//        
//        
//        addDateButton.backgroundColor = .green
//        addDateButton.setTitle("Add Date", for: .normal)
//        addDateButton.addTarget(self, action: #selector(dateButton), for: .touchUpInside)
//        addDateButton.frame = CGRect(x: 280, y: 680, width: 100, height: 100)
//        addDateButton.backgroundColor = UIColor.systemMint
//        NSLayoutConstraint.activate([
//            addDateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
//        ])
//
//    }
//   
//    @objc func datePickerValueChanged(_ sender: UIDatePicker){
//         
//         // Create date formatter
//         let dateFormatter: DateFormatter = DateFormatter()
//         
//         // Set date format
//         dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
//         
//         // Apply date format
//         let selectedDate: String = dateFormatter.string(from: sender.date)
//         
//         print("Selected value \(selectedDate)")
//     }
//     
//     override func didReceiveMemoryWarning() {
//         super.didReceiveMemoryWarning()
//         // Dispose of any resources that can be recreated.
//     }
//     
//    @objc func dateButton(sender: UIButton) {
//       print("uptodate")
//    }
//    
// }
//    
//

