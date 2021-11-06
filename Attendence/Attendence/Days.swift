//
//  Days.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore

struct DaysNames{
    var daysname :Timestamp
//    var attendance : Double
//    var absence : Double
}
class Days: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let db = Firestore.firestore()
    let button = UIButton(frame: CGRect(x: 180,y: 700,width: 200, height: 60))
    var collectionView: UICollectionView!
    var data:[DaysNames] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFirebase()
        setupCollectionView()
        setupUI()
    }
    
    func setupUI () {
        button.setTitle("Add Day",for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white,for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action:#selector(buttonAction),for:.touchUpInside)
    }
    func getDataFirebase () {
        Firestore.firestore().collection("Date").addSnapshotListener {
            snapshot, error in
            if error != nil {
                print(error as Any)
            }
            var time = [DaysNames]()
            for document in snapshot!.documents {
                let data = document.data()
                time.append(
                    DaysNames(
                        daysname: data["date"] as! Timestamp
                    )
                )
            }
            self.data = time
            self.collectionView.reloadData()
        }
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
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.timeZone = .autoupdatingCurrent
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            var ref: DocumentReference? = nil
            ref = self.db.collection("Date").addDocument(data: [
                "date": myDatePicker.date
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            print("Selected Date:\(myDatePicker.date)")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AttendenceSheet = AttendenceSheet()
        AttendenceSheet.selectedDate = data[indexPath.row]
        navigationController?.pushViewController(AttendenceSheet, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        let some = data[indexPath.row]
        let date = (some.daysname.dateValue())
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
       // formatter.locale = "ar"
        formatter.dateFormat = "EEEE, MMM d, yyyy"
      let resultDate =   formatter.string(from: date)
       cell.label.text = resultDate
        
//        cell.absencelabel.text = "\(some.absence)"
//        cell.attendancelabel.text = "\(some.attendance)"
        return cell
    }
}
