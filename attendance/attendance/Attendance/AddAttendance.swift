//
//  TVCell.swift
//  attendance
//
//  Created by ibrahim asiri on 28/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddAttendance: UIViewController {
    
  let datePicker = UIDatePicker()
  let tableView = UITableView(frame: .zero, style: .insetGrouped)
  var attendanceList: [AttendanceList] = []
  var currentlyPresent = 0
  var currentlyAbsent = 0
  let db = Firestore.firestore()
  var userEnteredDate = ""
    
  let createAttendanceBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.backgroundColor = .purple
    btn.setTitle("إنشاء قائمة الحضور", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.layer.cornerRadius = 10
    btn.clipsToBounds = true
    return btn
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
      
    title = "إضافة الحضور"
    view.backgroundColor = .lightGray
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
    datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(datePicker)
    datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    datePicker.widthAnchor.constraint(equalToConstant: 250).isActive = true
    datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
  }
    
  private func setupTableView(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 70
    tableView.register(AddAttendanceCell.self, forCellReuseIdentifier: AddAttendanceCell.cellID)
    view.addSubview(tableView)
  }
    
  private func setupButton() {
    createAttendanceBtn.translatesAutoresizingMaskIntoConstraints = false
    createAttendanceBtn.addTarget(self, action: #selector(createListTapped), for: .touchUpInside)
    view.addSubview(createAttendanceBtn)
    createAttendanceBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    createAttendanceBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    createAttendanceBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    createAttendanceBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
  }
    
  @objc func createListTapped() {
    writeDate()
  }
    
  @objc func dateChanged(_ sender: UIDatePicker) {
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
              self.attendanceList.append(AttendanceList(name: userName, isPresent: false))
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
        try db.collection("Attendance").document().setData(from: Attendances(date: userEnteredDate, teacherID: user.uid, presentNum: currentlyPresent, absentNum: currentlyAbsent, attendance: attendanceList))
        self.navigationController?.popViewController(animated: true)
      }catch{
        print("error saving attendance list")
      }
    }
  }
}

extension AddAttendance: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return attendanceList.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AddAttendanceCell.cellID, for: indexPath) as! AddAttendanceCell
    cell.name.text   = attendanceList[indexPath.row].name
    cell.isPresent.text = attendanceList[indexPath.row].isPresent ? "حاضر" : "غائب"
    return cell
  }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    attendanceList[indexPath.row].isPresent.toggle()
    tableView.reloadData()
  }
}

class AddAttendanceCell: UITableViewCell {

    static let cellID = "AddAttendanceCell"
    let name: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        return dl
    }()
    
    let isPresent: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return dl
    }()
    
    let details: UILabel = {
        let dl = UILabel()
        dl.textColor = .systemGray4
        dl.text = "انقر فوق الخلية لتغيير حالة الحضور".uppercased()
        dl.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dl.numberOfLines = 0
        dl.textAlignment = .right
        return dl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setUpCellViews() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10).isActive = true
        
        details.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(details)
        details.topAnchor.constraint(equalTo: name.bottomAnchor, constant: -10).isActive = true
        details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10).isActive = true
        details.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        isPresent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(isPresent)
        isPresent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        isPresent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
