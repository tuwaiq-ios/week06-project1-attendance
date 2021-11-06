//
//  DataStructs.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import Foundation
import FirebaseFirestore

struct Day {
    let date : Date
}


struct Student{
    let id: String
    let studentName: String
}
 
var days = [Day]()


var attendedStudents = [String]()
var students = [Student]()
var presented = [String]()
var absent = [String]()
