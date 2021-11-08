//
//  Day.swift
//  Attendence
//
//  Created by sara al zhrani on 03/04/1443 AH.
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
