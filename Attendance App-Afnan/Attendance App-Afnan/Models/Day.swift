//
//  Day.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import Foundation
import FirebaseFirestore


struct Day {
    let id: String
    let time: Timestamp
    let presentStudent: Array<String>
    
    func getNiceDate() -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: time.dateValue())
    }
}
