//
//  File.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit

struct StudentsData {
    var StudentName: String
    // var attendancelabel : Bool
    //var PicContact : String
}


//var sArray = [StudentsData(StudentName: "Ahmed", attendancelabel: true),
//              StudentsData(StudentName: "Mohammed", attendancelabel: true),
//              StudentsData(StudentName: "Fawaz", attendancelabel: true),
//              StudentsData(StudentName: "Hassan", attendancelabel: true),
//              StudentsData(StudentName: "Waleed", attendancelabel: true),
//              StudentsData(StudentName: "Ibrahim", attendancelabel: true)]

var addtoTable: Array <StudentsData> = []

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var attendancelabel = UILabel ()
    
    let BtnAdd = UIButton()
    
    let TV = UITableView()
    override func viewDidLoad() {
        //        ViewController.dataSource = self
        //        ViewController.delegate = self
        
        
        let Student = UILabel()
        Student.text = "Students"
        Student.translatesAutoresizingMaskIntoConstraints = false
        Student.textColor = .black
        Student.font = UIFont.boldSystemFont(ofSize: 30)
        view.backgroundColor = .white
        view.addSubview(Student)
        
        NSLayoutConstraint.activate([Student.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17 ),
                                     Student.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     Student.heightAnchor.constraint(equalToConstant: 90),
                                     Student.widthAnchor.constraint(equalToConstant: 140)
                                    ])
        attendancelabel.textColor = .black
        view.addSubview(attendancelabel)
        attendancelabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attendancelabel.topAnchor.constraint(equalTo: view.topAnchor,constant:100),
            attendancelabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            attendancelabel.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        
        super.viewDidLoad()
        
        
        TV.dataSource = self
        TV.delegate = self
        TV.register(Cell.self, forCellReuseIdentifier: "cell")
        TV.backgroundColor = .white
        TV.rowHeight = 80
        TV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TV)
        NSLayoutConstraint.activate([
            TV.leftAnchor.constraint(equalTo: view.leftAnchor),
            TV.rightAnchor.constraint(equalTo: view.rightAnchor),
            TV.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            TV.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1600),
            TV.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
        ])
        view.addSubview(BtnAdd)
        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        BtnAdd.backgroundColor = .orange
        // BtnAdd.addTarget(self, action: #selector(a), for: .touchUpInside)
        BtnAdd.backgroundColor = UIColor.gray
        BtnAdd.setTitle("+🧑🏻‍💻", for: .normal)
        BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(BtnAdd)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addtoTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = addtoTable[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! Cell
        cell.namecell.text = contact.StudentName
        
        return cell
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let secondController = showButton()
        secondController.callbackClosure = { [weak self] in
            self?.TV.reloadData()
        }
        
        present(secondController, animated: true, completion: nil)
    }
    
    
}

class Cell: UITableViewCell {
    
    let namecell = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        
        
        namecell.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(namecell)
        NSLayoutConstraint.activate(
            [namecell.centerYAnchor.constraint(equalTo: centerYAnchor),
             namecell.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

