//
//  SceneDelegate.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import Foundation

struct AttendanceList: Codable {
    let name: String
    var isPresent: Bool
}

struct Attendances: Codable {
    let date: String
    let teacherID: String
    var presentNum: Int
    var absentNum: Int
    let attendance: [AttendanceList]
}
struct Students {
    let name: String
}

