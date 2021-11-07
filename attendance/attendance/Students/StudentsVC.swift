//
//  SceneDelegate.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class StudentsVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let addStudentBtn = UIButton()
    let attendanceScreenBtn = UIButton()
    let studentsbtn = UIButton()
    
    let db = Firestore.firestore()
    
    var students: [Students] = []
    var attendanceList: [AttendanceList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        view.backgroundColor = .systemBrown
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "123")
        tableView.backgroundColor = .systemBrown
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupAddStudentBtn()
        setupStackView()
        signInUserAnms()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupAddStudentBtn() {
        
//        addStudentButton.circularButton()
        addStudentBtn.setTitle("➕", for: .normal)
        addStudentBtn.layer.cornerRadius = 22.5
        addStudentBtn.backgroundColor = .systemTeal
        addStudentBtn.setTitleColor(.white, for: .normal)
        addStudentBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        addStudentBtn.translatesAutoresizingMaskIntoConstraints = false
        addStudentBtn.addTarget(self, action: #selector(addStudentBtnTapped), for: .touchUpInside)
        view.addSubview(addStudentBtn)
        
        addStudentBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        addStudentBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addStudentBtn.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addStudentBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }

    @objc private func addStudentBtnTapped() {
        
        let naviagtionController = UINavigationController(rootViewController: AddStudent())
        naviagtionController.modalPresentationStyle = .pageSheet
        
        present(naviagtionController, animated: true)
        print("add button tapped")
    }
    
    private func setupStackView() {
        
        attendanceScreenBtn.setTitle("Days", for: .normal)
        attendanceScreenBtn.setTitleColor(.white, for: .normal)
        
        attendanceScreenBtn.addTarget(self, action: #selector(daysBtnTapped), for: .touchUpInside)
        
        studentsbtn.setTitle("Students", for: .normal)
        studentsbtn.setTitleColor(.white, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [studentsbtn, attendanceScreenBtn])
        stackView.backgroundColor = .blue.withAlphaComponent(0.9)
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
    
    @objc private func daysBtnTapped() {
        navigationController?.pushViewController(AttendanceVC(), animated: true)
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
    
    private func signInUserAnms() {
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

extension StudentsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath)
        cell.textLabel?.text = students[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            db.collection("Teacher").document().delete()
            tableView.reloadData()
            

        }
    }
}

