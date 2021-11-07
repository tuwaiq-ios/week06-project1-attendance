//
//  AppDelegate.swift
//  AttendanceApp
//
//  Created by Amal on 28/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddAttendanceScreen: UIViewController {
    
    let datePicker = UIDatePicker()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var attendanceList: [AttendanceListModel] = []
    var currentlyPresent = 0
    var currentlyAbsent = 0
    let db = Firestore.firestore()
    var userEnteredDate = ""
    let createAttendanceListButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.backgroundColor = .systemGray3
        btn.setTitle("New Attendance", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "New Attendance"
        view.backgroundColor = .systemGray6
        setupDatePicker()
        setupTableView()
        readData()
        setupButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 300, width: view.frame.size.width, height: view.frame.size.height - 450 )
    }
    private func setupDatePicker() {
        datePicker.calendar = .current
        datePicker.datePickerMode = .date
        //    if #available(iOS 13.4, *) {
        //      datePicker.preferredDatePickerStyle = .wheels
        //    }
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(AddAttendanceCell.self, forCellReuseIdentifier: AddAttendanceCell.cellID)
        view.addSubview(tableView)
    }
    private func setupButton() {
        createAttendanceListButton.translatesAutoresizingMaskIntoConstraints = false
        createAttendanceListButton.addTarget(self, action: #selector(createListTapped), for: .touchUpInside)
        view.addSubview(createAttendanceListButton)
        createAttendanceListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        createAttendanceListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        createAttendanceListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        createAttendanceListButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    @objc func createListTapped() {
        writeDate()
    }
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        userEnteredDate = dateFormatter.string(from: sender.date)
    }
    private func readData() {
        if let user = Auth.auth().currentUser{
            db
                .collection("Teacher")
                .whereField("teacherID", isEqualTo: user.uid)
                .addSnapshotListener { querySnapshot, error in
                    self.attendanceList = []
                    if let error = error {
                        print("There was an issue retrieving Students Information form FireStore. \(error)")
                    }else{
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if let userName = data["studentName"] as? String {
                                    self.attendanceList.append(AttendanceListModel(name: userName, isPresent: false))
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }else{
                                    print("print error getting converting data from firebase")
                                    return}}}}}
        }else {
            print("error getting current user")}}
    
    private func writeDate() {
        guard let user = Auth.auth().currentUser else {return}
        currentlyAbsent = 0
        currentlyPresent = 0
        for students in attendanceList {
            if students.isPresent == true {
                currentlyPresent += 1
            }else{
                currentlyAbsent += 1
            }
        }
        if userEnteredDate.isEmpty {
            let alert = UIAlertController(title: "Pick a date", message: "no date was enter", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            do {
                try db.collection("Attendance").document().setData(from: AttendanceFinal(date: userEnteredDate, teacherID: user.uid, presentNumber: currentlyPresent, absentNumber: currentlyAbsent, attendance: attendanceList))
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("error saving attendance list")}}}}

extension AddAttendanceScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddAttendanceCell.cellID, for: indexPath) as! AddAttendanceCell
        cell.name.text   = attendanceList[indexPath.row].name
        cell.isPresent.text = attendanceList[indexPath.row].isPresent ? "P" : "A"
        return cell}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        attendanceList[indexPath.row].isPresent.toggle()
        tableView.reloadData()}}

