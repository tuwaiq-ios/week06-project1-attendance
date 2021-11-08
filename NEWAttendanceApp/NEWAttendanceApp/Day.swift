//
//  Day.swift
//  NEWAttendanceApp
//
//  Created by dmdm on 08/11/2021.
//

import Foundation
import FirebaseFirestore

struct Day {
    let id: String
    let timestamp: Timestamp
    var pStudents: Array<String>
    
    func getNiceDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: timestamp.dateValue())
    }
}
