//
//  Model.swift
//  Attendance
//
//  Created by alanood on 01/04/1443 AH.
//

import UIKit

struct AttendanceListModel: Codable {
    let name: String
    var isPresent: Bool
}

struct AttendanceFinal: Codable {
    let date: String
    let teacherID: String
    var presentNumber: Int
    var absentNumber: Int
    let attendance: [AttendanceListModel]
}

struct Students {
    let name: String
}

