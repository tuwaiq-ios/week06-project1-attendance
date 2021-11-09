//
//  data.swift
//  attendance
//
//  Created by Hassan Yahya on 28/03/1443 AH.
//

import UIKit

import Firebase
import Foundation
import FirebaseFirestore

struct Day {
	var timestamp : Timestamp
	var pStudents : Array<String>
	var id : String
	
	func getNiceDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		
		return dateFormatter.string(from: timestamp.dateValue())
	}
}


var Addnews : Array<Students> = []

struct Students {
	let name : String!
	var id : String
}
