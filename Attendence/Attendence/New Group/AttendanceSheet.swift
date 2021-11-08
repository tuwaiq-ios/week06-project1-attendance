//
//  AttendenceSheet.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore

class AttendanceSheet: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
 
    
    var dayId: String
    var day: Day?
    var students: Array<Student> = []
    
    init (dayId: String) {
        self.dayId = dayId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dayId = ""
        super.init(coder: coder)
    }
    
    
    var collectionView: UICollectionView!
    let  attendance = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  attendancenumber = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  absence = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  absencenumber = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUi()
        
        
        DaysService.shared.listenToDay(dayId: dayId) { newDay in
            self.day = newDay
            self.title = newDay?.getNiceDate()
            self.updateViews()
        }
        
        StudentsService.shared.listenToStudents { newStudents in
            self.students = newStudents
            self.updateViews()
        
    }
        
        
    }
    
    func updateViews() {
        attendancenumber.text = "P: \(getPStudentsCount())"
        absencenumber.text = "A: \(getAStudentsCount())"
        collectionView.reloadData()
    }
    
    
        
    func setupUi () {
        attendance.center = CGPoint(x: 110, y: 110)
        attendance.font = UIFont.systemFont(ofSize: 20)
        attendance.textColor = .black
        attendance.textAlignment = .left
        attendance.text = "Attendance..."
        
        attendancenumber.center = CGPoint(x: 120, y: 160)
        attendancenumber.font = UIFont.systemFont(ofSize: 20)
        attendancenumber.textColor = .systemMint
        attendancenumber.textAlignment = .left
        attendancenumber.text = "33"
        
        absence.center = CGPoint(x: 250, y: 110)
        absence.font = UIFont.systemFont(ofSize: 20)
        absence.textColor = .black
        absence.textAlignment = .right
        absence.text = "Absence.."
        
        absencenumber.center = CGPoint(x: 210, y: 160)
        absencenumber.font = UIFont.systemFont(ofSize: 20)
        absencenumber.textColor = .systemIndigo
        absencenumber.textAlignment = .right
        absencenumber.text = "0"
        
        self.view.addSubview(attendance)
        self.view.addSubview( attendancenumber)
        self.view.addSubview(absence)
        self.view.addSubview(absencenumber)
        
    }

        func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: view.frame.width, height: 100)
            collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .systemGray5
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(AttendenceCell.self, forCellWithReuseIdentifier: AttendenceCell.identifier)
            self.view.addSubview(collectionView)
           
        }
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttendenceCell.identifier, for: indexPath) as! AttendenceCell
        
        let student = students[indexPath.row]
        cell.namelabel.text = student.name
        
        
        let isStudentPresent = checkStudentPresent(studentId: student.id)
        if isStudentPresent {
            cell.attendancelabel.text = "p"
        } else {
            cell.absencelabel.text = "A"

        }
    
        return cell
    }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: false)
            
            let student = students[indexPath.row]
            
            DaysService.shared.switchStudentStatus(
                day: day!,
                studentId: student.id
            )
            
            collectionView.reloadData()
        }
        
        
        func checkStudentPresent(studentId: String) -> Bool {
            return day?.pStudents.contains(studentId) ?? false
        }
        
        func getPStudentsCount() -> Int {
            return day?.pStudents.count ?? 0
        }
        
        func getAStudentsCount() -> Int {
            let pStudentsCount = getPStudentsCount()
            return students.count - pStudentsCount
        }
        
    
        
        
}







