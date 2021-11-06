//
//  DateViewController.swift
//  Attendance
//
//  Created by Eth Os on 30/03/1443 AH.
//

import UIKit
import FirebaseFirestore

class DateViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let presentLabel = UILabel()
    let absentLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var totalStudent = students.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        setupLabels()
        setupCollectionView()
        
    }
    
    func setupLabels(){
        presentLabel.text = "P : \(attendedStudents.count)"
        presentLabel.textColor = UIColor(red: 120.0/225.0, green: 148.0/225.0, blue: 234.0/225.0, alpha: 1.0)
        presentLabel.font = .boldSystemFont(ofSize: 40)
        presentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentLabel)
        NSLayoutConstraint.activate([
            presentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            presentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
        
        
        
        
        absentLabel.text = "A : \(students.count)"
        absentLabel.textColor = UIColor(red: 212.0/255.0, green: 38.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        absentLabel.font = .boldSystemFont(ofSize: 40)
        absentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(absentLabel)
        NSLayoutConstraint.activate([
            absentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            absentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
    }
    
    func setupCollectionView(){
      
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "date")
       
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: presentLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if students.count > 0 {
            return students.count
        }else{
            return students.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
        let data = students[indexPath.row]
        
        cell.studentNameLabel.text = data.studentName
        if !cell.isSelected{
            cell.statLabel.text = "A"
            cell.statLabel.textColor = .red }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = students[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
         
                cell.statLabel.text = "P"
                cell.statLabel.textColor = .blue
                attendedStudents.append(data.studentName)
                presentLabel.text = "P : \(attendedStudents.count)"
                totalStudent -= 1
                absentLabel.text = "A : \(totalStudent)"
            }
            
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 350, height: 50)
        }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
