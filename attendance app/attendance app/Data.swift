//
//  Data.swift
//  attendance app
//
//  Created by Ahmed Assiri on 29/03/1443 AH.
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



struct Student {
    let name: String
    let id: String
}
