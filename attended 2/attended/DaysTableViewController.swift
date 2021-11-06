//
//  DaysTableViewController.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//
//
//

import UIKit
import FirebaseFirestore
import Firebase

class DaysViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let Day = UITableView()
    let DayLabel = UILabel()
    var days = [Days]()
    
    //                (name: "Sat", Date: , id: 1),
    //                Days(name: "Sun", Date: "dd-mm-yyyy", id: 1),
    //                Days(name: "Mon", Date: "11-22-2020", id: 1),
    //                Days(name: "Wed", Date: "11-22-2020", id: 1)]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a date : "
        
        
        Day.delegate = self
        Day.dataSource = self
        Day.translatesAutoresizingMaskIntoConstraints = false
        Day.backgroundColor = .white
        Day.register(UITableViewCell.self, forCellReuseIdentifier: "Cell1")
        view.addSubview(Day)
        NSLayoutConstraint.activate([
            Day.topAnchor.constraint(equalTo: view.topAnchor),
            Day.bottomAnchor.constraint(equalTo:view.bottomAnchor),
            Day.leftAnchor.constraint(equalTo: view.leftAnchor),
            Day.rightAnchor.constraint(equalTo: view.rightAnchor),
            
        ])
        
        view.addSubview(DayLabel)
        DayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DayLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:90),
            DayLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            DayLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        createDatePicker()
        
        
        view.backgroundColor = .white
        birthDateTxt.placeholder = "touch to choose a date"
        birthDateTxt.textAlignment = .center
        birthDateTxt.translatesAutoresizingMaskIntoConstraints = false
        birthDateTxt.textColor = .black
        birthDateTxt.font = UIFont.systemFont(ofSize: 30)
        birthDateTxt.backgroundColor = .systemGray5
        
        view.addSubview(birthDateTxt)
        
        NSLayoutConstraint.activate([
            birthDateTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthDateTxt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            birthDateTxt.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        BtnOK.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnOK)
        
        NSLayoutConstraint.activate([
           BtnOK.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            BtnOK.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            BtnOK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350)
        ])
        
        //fireBase
        Firestore.firestore().collection("Days").addSnapshotListener {
            snapshot,error in
            if error != nil {
                print (error)
                return
            }
            var DaysArray = [Days]()
            for document in snapshot!.documents{
                let data = document.data()
                
                DaysArray.append(
                    Days(
                        name: data["name"] as! String,
                        Date1: data["Date1"] as! Timestamp,
                        id: data["id"] as! Int
//                        attendStudent: [Student]()
                    )
                )
                
            }
            self.days = DaysArray
            self.Day.reloadData()
        }
        
        BtnOK.backgroundColor = UIColor.blue
        BtnOK.setTitle("Add Day", for: .normal)
        
        func buttonAction(sender: UIButton!) {
            
            
            let btnsendtag: UIButton = sender
            if btnsendtag.tag == 1 {
                dismiss(animated: true, completion: nil)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        let data = days[indexPath.row]
        cell2.backgroundColor = .clear
        cell2.textLabel?.text = "\(data.Date1)"
        
    
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
       
        return cell2
    }
    
    var birthDateTxt = UITextField()
    let datePicker = UIDatePicker()
    let BtnOK = UIButton()
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = studentsViewController()
        
        vc.studentday = days[indexPath.row]
        
        navigationController?.pushViewController(vc , animated: true)
    }
    func createDatePicker(){
        
        birthDateTxt.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (donePressed))
        toolbar.setItems ([doneBtn], animated: true)
        
        birthDateTxt.inputAccessoryView = toolbar
        
        datePicker.preferredDatePickerStyle = .wheels
        birthDateTxt.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthDateTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    //    func getDays() {
    //        Firestore.firestore().collection("Days").addSnapshotListener {
    //            snapshot, error in
    //            if error == nil {
    //                guard let daysID = Auth.auth().currentUser?.uid else {
    //                    return
    //                }
    //                for document in snapshot!.documents{
    //                    let data = document.data()
    //
    //                    if data["daysID"] as? String != daysID {
    //                        self.days.append(Day)
    //                    }
    //                }
    //            }
    //        }
    
}


//class Dayscell : UITableViewCell {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
//
//
// //  cell3.backgroundColor = .green
//        return cell3
//
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//          }
//}
//


