//
//  threeVC.swift
//  attendanccc
//
//  Created by sally asiri on 28/03/1443 AH.
//


import UIKit
import FirebaseFirestore

public struct Student {
    let id: String
    let name: String
    var attendance: Bool
}
var students = [Student]()

var b1 = " \(students.filter({ Student in Student.attendance}).count)"
var c1 = b1
var b2 =  " \(students.filter({ Student in !Student.attendance}).count)"
var c2 = b2

var t:Days?
class AttendancePage: UIViewController,
               UITableViewDelegate,
               UITableViewDataSource {
    
//    var t:Lis?
    var data = [Days]()
    let tv = UITableView()
    
    var students = [Student]()
    
    
    let dayl: UILabel = {
        let label = UILabel()
       label.text = "3 Nov"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    let attandanceLabel = UILabel()
    let attandanceLabel2 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.title = "Attendance Page"
    

//        self.title = t?.date
        

      
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(Cell3.self, forCellReuseIdentifier: Cell3.identifire)
        view.addSubview(tv)
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tv.leftAnchor.constraint(equalTo: view.leftAnchor),
            tv.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        
        
        view.addSubview(dayl)
        dayl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayl.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            dayl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 180),
            dayl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 80),
        ])
        
        
        view.addSubview(attandanceLabel2)
        attandanceLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attandanceLabel2.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            attandanceLabel2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 260),
            attandanceLabel2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 120),
        ])
        
        
        view.addSubview(attandanceLabel)
        attandanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attandanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            attandanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            attandanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 80),
        ])
        
        attandanceLabel.text =  "present = \(students.filter({ Student in Student.attendance}).count)"
        
        attandanceLabel2.text = "Apsent = \(students.filter({ Student in !Student.attendance}).count)"
        
//        tv.reloadData()
        
        Firestore.firestore().collection("students").addSnapshotListener{ snapshot, error in
            if error != nil {
                print(error)
                return
            }
            
            var studentsArray = [Student]()
         for document in snapshot!.documents {
                
                let data = document.data()
             studentsArray.append(
                Student( id: data["id"] as! String, name: data["name"] as! String, attendance: data["attendance"] as! Bool)
             
             
             )
            }
            self.students = studentsArray
            self.tv.reloadData()
            
        }
        
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell3.identifire, for: indexPath) as! Cell3
        
        
        let student = students[indexPath.row]
        
        cell.label5.text = student.name
        
    
        if student.attendance {
            cell.label6.text = "P"
        }else{
            cell.label6.text = "A"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let student = students[indexPath.row]
        students[indexPath.row].attendance =
        !students[indexPath.row].attendance
        
        Firestore.firestore().document("students/\(student.id)")
            .updateData(["attendance": !student.attendance])
        
        var b1 = "Present = \(students.filter({ Student in Student.attendance}).count)"
        var c1 = b1
        var b2 =  "Apsent = \(students.filter({ Student in !Student.attendance}).count)"
        
        attandanceLabel.text = "\(b1)"
        attandanceLabel2.text = "\(b2)"
        
        tableView.reloadData()
       
    }
}

class Cell3: UITableViewCell {
    
    static let identifire = "cell"
    
    public let label5: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    public let label6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        //
        return label
    }()
    
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        contentView.backgroundColor = .purple
        
        contentView.addSubview(label5)
        contentView.addSubview(label6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        label5.frame = CGRect(x: 5,
                              y: 5,
                              width: 260,
                              height: contentView.frame.size.height-10)
        
        label6.frame = CGRect(x: 300,
                              //                                up or down
                              y: 5,
                              width: 90,
                              height: contentView.frame.size.height-10)
        
    }
    
}



