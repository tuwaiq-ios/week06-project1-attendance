//
//  ViewController.swift
//  Attendance
//
//  Created by Tsnim Alqahtani on 29/03/1443 AH.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {


    let tv = UITableView()
    let attendanceLabel = UILabel()
    var students = [
        Student(name: "sara", attendance: true),
        Student(name: "tasnim", attendance: true),
        Student(name: "deema", attendance: true),
        Student(name: "rania", attendance: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.topAnchor),
            tv.bottomAnchor.constraint(equalTo:view.bottomAnchor),
            tv.leftAnchor.constraint(equalTo: view.leftAnchor),
            tv.rightAnchor.constraint(equalTo: view.rightAnchor),

            ])
      
        view.addSubview(attendanceLabel)
        attendanceLabel.font = .italicSystemFont(ofSize: 20)
//        attendanceLabel.font = .boldSystemFont(ofSize: 20)
        attendanceLabel.frame = .infinite
        attendanceLabel.textColor = .brown
        attendanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attendanceLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:90),
            attendanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            attendanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
       

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let student = students [indexPath.row]
        cell.backgroundColor = .green
        cell.textLabel?.text = students[indexPath.row].name
        
        if student.attendance{
            cell.backgroundColor = .lightGray
        }else{
            cell.backgroundColor = .red
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        students[indexPath.row].attendance = !students[indexPath.row].attendance
        attendanceLabel.text = "students count = \(students.filter ({student in student.attendance }).count)"
        tableView.reloadData()
    }
}
