//
//  Days.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore


class Days: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var days: Array<Day> = []
    var studentCount = 0
    
    let button = UIButton(frame: CGRect(x: 180,y: 700,width: 200, height: 60))
    var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
        
        
        DaysService.shared.listenToDays { newDays in
            self.days = newDays
            self.collectionView.reloadData()
        }
        StudentsService.shared.listenToStudentCount { newStudentCount in
            self.studentCount = newStudentCount
            self.collectionView.reloadData()
        }
        
    }
    
    func setupUI () {
        button.setTitle("Add Day",for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white,for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action:#selector(buttonAction),for:.touchUpInside)
    }
 
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 201, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        self.view.addSubview(collectionView)
        self.view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 100).isActive = true
    }
    @objc func buttonAction() {
        
        let newDayVC = NewDayVC()
        present(newDayVC, animated: true, completion: nil)
    }
     
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        let day = days[indexPath.row]
        let pStudentCount = day.pStudents.count
        let aStudentCount = studentCount - pStudentCount
        
        cell.label.text = day.getNiceDate()
        cell.absencelabel.text = "P: \(pStudentCount), A: \(aStudentCount)"
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        
        let navigationController = UINavigationController(
            rootViewController: AttendanceSheet(dayId: day.id)
        )
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true, completion: nil)
    
    }
    
    
    
}
