//
//  AttendanceCell.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 30/03/1443 AH.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol checkButtondelgate{
    
    func checkTaskTapped(at indexpath: IndexPath )
}

class AttendanceCell: UITableViewCell, UITextFieldDelegate {
    
    var delgate: checkButtondelgate!
    
    var indexpath: IndexPath!
    
    static let identefire = "nameCell"
    
    var studentname: UITextField = UITextField()
    
    var AttendanceButton: UIButton = UIButton()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        studentname.delegate = self
    }
    
    func buttocell1(_ sender: Any) {
        
        delgate.checkTaskTapped(at: indexpath)
            
    }
    
    var nameArray = [StudentsName]()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let update = StudentsName(name: "\(String(describing: studentname.text))", attendance:  nameArray[indexpath.row].attendance)
             nameArray[indexpath.row] = update
        studentname.resignFirstResponder()
                return true
        
    }
    
    
}
