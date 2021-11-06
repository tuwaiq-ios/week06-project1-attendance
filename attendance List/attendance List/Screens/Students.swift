//
//  StudentsScreen.swift
//  attendance List
//
//  Created by Maram Al shahrani on 30/03/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class StudentsScreen: UIViewController {
    
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let addStudentButton = UIButton(type: .system)
    
    let attendanceScreenButton = UIButton(type: .system)
    
    let studentsButton = UIButton(type: .system)
    
    let db = Firestore.firestore()
    
    var students: [Students] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        
        view.backgroundColor        = .systemGray6
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "123")
        
        view.addSubview(tableView)
        
        tableView.delegate          = self
        
        tableView.dataSource        = self
        
        setupAddStudentButton()
        setupStackView()
        signInUserAnonymous()
        
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    private func setupAddStudentButton() {
        
        
        addStudentButton.circularButton()
        addStudentButton.translatesAutoresizingMaskIntoConstraints = false
        
        addStudentButton.addTarget(self, action: #selector(addStudentButtonTapped), for: .touchUpInside)
        
        view.addSubview(addStudentButton)
        
        addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        addStudentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addStudentButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addStudentButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
    }
    
    
    @objc private func addStudentButtonTapped() {
        
        let naviagtionController = UINavigationController(rootViewController: AddStudentScreen())
        naviagtionController.modalPresentationStyle = .pageSheet
        
        present(naviagtionController, animated: true)
        print("add button tapped")
    }
    
   

    private func setupStackView() {
        
        
        attendanceScreenButton.setTitle("Days", for: .normal)
        attendanceScreenButton.setTitleColor(.black, for: .normal)
        
        attendanceScreenButton.addTarget(self, action: #selector(daysButtonTapped), for: .touchUpInside)
        
        studentsButton.setTitle("Student", for: .normal)
        studentsButton.setTitleColor(.black, for: .normal)
        
        
        let stackView = UIStackView(arrangedSubviews: [studentsButton, attendanceScreenButton])
        stackView.backgroundColor = .systemGray2
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(stackView)
        
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
    }
    
    
    @objc private func daysButtonTapped() {
        navigationController?.pushViewController(AttendanceScreen(), animated: true)
        print("Go to days")
    }

    

    
    private func readData() {
        print("Fired read Data")
        if let user = Auth.auth().currentUser{
            db
            .collection("Teacher")
            .whereField("teacherID", isEqualTo: user.uid)
            .addSnapshotListener { querySnapshot, error in
            
            self.students = []
            
            if let error = error {
                print("There was an issue retrieving Students Information form FireStore. \(error)")
            }else{
                
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        
                        if let userName = data["studentName"] as? String {
                            
                            self.students.append(Students(name: userName))
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                            
                        }else{
                            print("print error getting converting data from firebase")
                            return
                        }
                        
                        
                    }
                }
                
                
            }
            
        }
            
            
            
        }else {
            print("error getting current user")
            
        }
    }
    
    private func signInUserAnonymous() {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {print("error sign in user"); return}
           
                        if let thereiserror = error {
                            print("print error saving students \(thereiserror)")
                        }else{
                            print("Successfully singed in teacher")
                            self.readData()
                        }
                
            }
        }
    
}




extension StudentsScreen: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath)
        cell.textLabel?.text = students[indexPath.row].name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
