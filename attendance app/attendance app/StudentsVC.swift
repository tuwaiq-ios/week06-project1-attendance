//
//  Student.swift
//  attendance app
//
//  Created by Ahmed Assiri on 01/04/1443 AH.
//

import UIKit

class StudentsVC: UIViewController {
    var students: Array<Student> = []
    
    lazy var studentsTV: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
        return t
    }()
    
    lazy var addStudentButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(addStudent), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Add", for: .normal)
        b.backgroundColor = .red
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentsService.shared.listenToStudents { newStudents in
            self.students = newStudents
            self.studentsTV.reloadData()
        } //end
        
        tabBarItem = UITabBarItem(title: "Students",
                                  image: UIImage(systemName: "person")
                                  , selectedImage: nil)
        view.backgroundColor = .brown
        
        view.addSubview(studentsTV)
        NSLayoutConstraint.activate([
            studentsTV.topAnchor.constraint(equalTo: view.topAnchor),
            studentsTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            studentsTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentsTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(addStudentButton)
        NSLayoutConstraint.activate([
            addStudentButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            addStudentButton.widthAnchor.constraint(equalToConstant: 100),
            addStudentButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    } //end
    
    @objc func addStudent() {
        let newStudentVC = NewStudentVC()
        present(newStudentVC, animated: true, completion: nil)
    }//end
}


// تابع للكلاس الاساسي
extension StudentsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath)
        
        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name
        
        return cell
    }
}
