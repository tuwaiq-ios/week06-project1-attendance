//
//  StudentViewController.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import UIKit
import DTGradientButton
import FirebaseFirestore

class StudentViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let addStudentButton    = UIButton()
    let collectionView      = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let gradientLayer       = CAGradientLayer()
    var students            = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        setupAddStudentButton()
        setuoCollectionView()
    
        StudentService.shared.studentListenr { newStudents in
            self.students = newStudents
            self.collectionView.reloadData()
        }
        
       
    }
    
    @objc func addStudentTapped(){
        
        let vc      = NewStudentViewController()
        vc.title    = "New Student"
        let navVC   = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true, completion: nil)
                    
    }
  
    
    func setupAddStudentButton(){
        let topColor    = UIColor(red: 120.0/255.0, green: 148.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 42.0/255.0, green: 74.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        let colorsArray = [topColor, bottomColor]
    
        addStudentButton.setGradientBackgroundColors(colorsArray,
                                                 direction: .toBottom,
                                                 for: .normal)
        
        addStudentButton.setTitle("Add Student", for: .normal)
        addStudentButton.titleLabel?.font       = .boldSystemFont(ofSize: 18)
        addStudentButton.layer.masksToBounds    = true
        addStudentButton.layer.cornerRadius     = 10.0
        
        addStudentButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addStudentButton)
        NSLayoutConstraint.activate([
            addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            addStudentButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            addStudentButton.heightAnchor.constraint(equalToConstant: 100),
            addStudentButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        
        addStudentButton.addTarget(self, action: #selector(addStudentTapped), for: .touchUpInside)
   }
    
    func setuoCollectionView(){
      
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.backgroundColor      = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: "student")
       
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "student", for: indexPath) as! StudentCollectionViewCell
        let data = students[indexPath.row]
        
        cell.studentNameLabel.text = data.studentName
        
        return cell
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
