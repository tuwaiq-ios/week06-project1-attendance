//
//  AttendenceSheet.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore

class AttendenceSheet: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var collectionView: UICollectionView!
    let  attendance = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  attendancenumber = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  absence = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let  absencenumber = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    var selectedDate:DaysNames?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUi()
        setDateForTitle()
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
        attendancenumber.text = "\(names.filter({ names in names.iScompletd }).count)"
        
    }
    func setDateForTitle() {
        let date = selectedDate?.daysname.dateValue() ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        // formatter.locale = "ar"
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let resultDate = formatter.string(from: date)
            self.navigationItem.title = resultDate
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 100, left: 0, bottom:0 , right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        
        collectionView = UICollectionView(frame: self.view.frame,collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AttendenceCell.self, forCellWithReuseIdentifier: AttendenceCell.identifier)
        self.view.addSubview(collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        names[indexPath.row].iScompletd = !names[indexPath.row].iScompletd
        attendancenumber.text = "\(names.filter({ names in names.iScompletd }).count)"
//        Firestore.firestore().document("users").updateData(["iScompletd": !Students.iScompletd])
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttendenceCell.identifier, for: indexPath) as! AttendenceCell
        // let inform = listStudent[indexPath.row]
        
        
        cell.namelabel.text = names[indexPath.row].name
        //        cell.attendancelabel.text = inform.attendance
        //        cell.absencelabel.text = "\(inform.absence)"
        
        //        if inform.comin {
        //            cell.attendancelabel.backgroundColor = .green
        //        }else{
        //
        //            cell.attendancelabel.backgroundColor = .red
        //        }
        
        return cell
    }
}







