//
//  DaysTableViewController.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//
//
//


////////////////////////////////////

import UIKit
import FirebaseFirestore
import Firebase

class DaysViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let Day = UITableView()
    let DayLabel = UILabel()
    var days = [Days]()


    override func viewDidLoad() {
        super.viewDidLoad()


        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

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
            DayLabel.topAnchor.constraint(equalTo: view.topAnchor ,constant:300),
            DayLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            DayLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            DayLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)

        ])

        ///////////////////////super.viewDidLoad()
        ///
        createDatePicker()


        view.backgroundColor = .white
        birthDateTxt.placeholder = "touch to choose a date"
        birthDateTxt.textAlignment = .center
        birthDateTxt.translatesAutoresizingMaskIntoConstraints = false
        birthDateTxt.textColor = .black
        birthDateTxt.font = UIFont.systemFont(ofSize: 15)
        birthDateTxt.backgroundColor = .systemGray5

        view.addSubview(birthDateTxt)

        NSLayoutConstraint.activate([
            birthDateTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthDateTxt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            birthDateTxt.widthAnchor.constraint(equalToConstant: 200),
            birthDateTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            birthDateTxt.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100)
        ])

        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnAdd)

        NSLayoutConstraint.activate([
            //            BtnAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //             BtnAdd.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //        BtnAdd.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            //        BtnAdd.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        //fireBase
        Firestore.firestore().collection("days").addSnapshotListener {
            snapshot,error in
            if error != nil {
                print (error)
                return
            }
            var DaysArray = [Days]()
            for document in snapshot!.documents{
                let data = document.data()
                
                print(data)
        
                DaysArray.append(
                    Days(
                        name: data["name"] as! String,
                        Date1: data["Date1"] as! Timestamp,
                        id: data["id"] as! Int
                    )
                )

            }
            self.days = DaysArray
            self.Day.reloadData()
        }



        BtnAdd.backgroundColor = UIColor.blue
        BtnAdd.setTitle("Add Day", for: .normal)

        func buttonAction(sender: UIButton!) {

//            Firestore
//                .firestore()
//                .document("Days/Date")
//                .setData([
//
//                    "id" : 1,
//                    "name" : "sat",
//                    "Date1" : birthDateTxt
//                ])
//


//
//            let alertController = UIAlertController(title: "⚠️", message: "Date ✅", preferredStyle: .alert)
//
//
//            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(okAction)
//
//            present(alertController, animated: true, completion: nil)
//
//

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
        // tableView.deselectRow(at: indexPath, animated: false)
        //  days[indexPath.row].Date = days[indexPath.row].Date
        //  tableView.reloadData()
        title = "Choose a date : "

        let data = days[indexPath.row]
        cell2.backgroundColor = .clear
        cell2.textLabel?.text = "\(data.Date1)"



        return cell2
    }

    var birthDateTxt = UITextField()
    let datePicker = UIDatePicker()
    let BtnAdd = UIButton()




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //studentsViewController()
        //    performSegue(withIdentifier: "sendDate", sender: studentsViewController())

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

}
