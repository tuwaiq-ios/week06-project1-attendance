//
//  DataStructs.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import Foundation
import FirebaseFirestore

struct Day {
    let id: String
    let date : Date
    let attendenc: Array<String>
}


struct Student{
    let id: String
    let studentName: String
}
 

