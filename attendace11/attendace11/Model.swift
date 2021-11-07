//
//  AppDelegate.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit

import Firebase
import Foundation
import FirebaseFirestore

struct Day {
    let date : Date
}


//struct Student{
//    let id: String
//    let studentName: String
//}
 
//var days = [Day]()


var attendedStudents = [String]()
//var students = [Student]()
var presented = [String]()
var absent = [String]()



var todayday : Array<Day> = []
var Addnews : Array<Students> = []

struct Students {
    let name : String!
}
