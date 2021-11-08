//
//  ViewController.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import UIKit
import DTGradientButton
import FirebaseFirestore

class DaysViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let addDayButton    = UIButton()
    let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let gradientLayer   = CAGradientLayer()
    var days            = [Day]()
    var studentCount    = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        DayService.shared.allDaysListenr { days in
            self.days = days
            self.collectionView.reloadData()
        }
        
        StudentService.shared.listenToStudentCount { studentCount in
            self.studentCount = studentCount
            self.collectionView.reloadData()
        }
        
        setupAddDayButton()
        setupCollectionView()
    
        
        collectionView.reloadData()
    }
    
    @objc func addDayTapped(){
        
        let vc       = NewDayViewController()
        vc.title     = "New Day"
        let navVC    = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true, completion: nil)
    }
  
    
    func setupAddDayButton(){
        let topColor    = UIColor(red: 245.0/255.0, green: 176.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 212.0/225.0, green: 38.0/225.0, blue: 28.0/225.0, alpha: 1.0)
        let colorsArray = [topColor, bottomColor]
        
        addDayButton.setGradientBackgroundColors(colorsArray,
                                                 direction: .toBottom,
                                                 for: .normal)
        
        addDayButton.setTitle("Add Day", for: .normal)
        
        addDayButton.titleLabel?.font       = .boldSystemFont(ofSize: 18)
        addDayButton.layer.masksToBounds    = true
        addDayButton.layer.cornerRadius     = 10.0
        
        addDayButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addDayButton)
        NSLayoutConstraint.activate([
            addDayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            addDayButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            addDayButton.heightAnchor.constraint(equalToConstant: 100),
            addDayButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        addDayButton.addTarget(self, action: #selector(addDayTapped), for: .touchUpInside)
   }
    
    func setupCollectionView(){
      
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.backgroundColor      = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(DaysCollectionViewCell.self, forCellWithReuseIdentifier: "days")
       
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if days.count > 0{
            return days.count
        }else{
            return days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "days", for: indexPath) as! DaysCollectionViewCell
        
        let data                = days[indexPath.row]
        
        let formatter           = DateFormatter()
        formatter.dateFormat    = "EEEE, MMM d"
        let formatedDate        = formatter.string(from: data.date)
        
        cell.dayNameLabel.text  = formatedDate
        
        let pStudentCount       = data.attendenc.count
        let aStudentCount       = studentCount - pStudentCount
        
        cell.aLabel.text        = "\(aStudentCount)"
        cell.pLabel.text        = "\(pStudentCount)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data                 = days[indexPath.row]

        let nextVC               = DateViewController(dayID: data.id)
        
        let formatter            = DateFormatter()
        formatter.dateFormat     = "EEEE, MMM d"
        let formatedDate         = formatter.string(from: data.date)
     
        nextVC.title             = formatedDate

        navigationController?.pushViewController(nextVC, animated: true)

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


