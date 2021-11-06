//
//  model.swift
//  attendance List
//
//  Created by Maram Al shahrani on 28/03/1443 AH.
//

import Foundation



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
