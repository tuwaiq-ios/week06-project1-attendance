//
//  date.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//

    import UIKit
    class AllStudentsNames: UIViewController , UITableViewDelegate , UITableViewDataSource{
        
        let tv = UITableView()
        let attendanceLabel = UILabel()
        var students = [
            Student(name: "1- tasnim", attendance: true),
            Student(name: "2- sara", attendance: true),
            Student(name: "3- Reem", attendance: true),
            Student(name: "4- Ranim", attendance: true),
            Student(name: "5- eveleen", attendance: true),
            Student(name: "6- samar", attendance: true),
            Student(name: "7- fatemah", attendance: true),
            Student(name: "8- dalal", attendance: true),
            Student(name: "9- nora", attendance: true),
            Student(name: "10- maryam", attendance: true),
            Student(name: "11- yara", attendance: true)
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            tv.delegate = self
            tv.dataSource = self
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.backgroundColor = .systemIndigo
            tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            view.addSubview(tv)
            NSLayoutConstraint.activate([
                tv.topAnchor.constraint(equalTo: view.topAnchor),
                tv.bottomAnchor.constraint(equalTo:view.bottomAnchor),
                tv.leftAnchor.constraint(equalTo: view.leftAnchor),
                tv.rightAnchor.constraint(equalTo: view.rightAnchor),

                ])
          
            view.addSubview(attendanceLabel)
            attendanceLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                attendanceLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:90),
                attendanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
                attendanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            ])
           

        }
        
        
        @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return students.count
        }
        
        @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            

          cell.textLabel?.text = students[indexPath.row].name
            

               cell.backgroundColor = .systemMint

           return cell


        
        }}
