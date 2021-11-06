//
//  DayController.swift
//  StudentsAttandance-hanan
//
//  Created by  HANAN ASIRI on 28/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

struct Days {
  var dayname: Timestamp
    //var attandance: bool
    //  var absent: bool
}

//var days = [Days]()
var days = [Days]()
class DayController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    let db = Firestore.firestore()
    var dateFormatter: DateFormatter = DateFormatter()
    
    let tableview: UITableView = UITableView()
    let daybutton: UIButton = UIButton()
    let namelabel = UILabel(frame: CGRect(x: 0, y:0 , width: 200, height: 25))
  
    override func viewDidLoad() {
        
    super.viewDidLoad()
        view.backgroundColor = .white
    tableview.delegate = self
    tableview.dataSource = self
        tableview.backgroundColor = .orange
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: DaysCell.identefier)
    tableview.translatesAutoresizingMaskIntoConstraints = false
   
    view.addSubview(tableview)
    view.addSubview(daybutton)
    view.addSubview(namelabel)
        
        
        namelabel.center = CGPoint(x: 120, y: 70)
        namelabel.font = UIFont.systemFont(ofSize: 24)
        namelabel.textColor = .brown
        namelabel.textAlignment = .left
        namelabel.text = "Days"
   
        
        NSLayoutConstraint.activate([
      tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
      tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableview.rightAnchor.constraint(equalTo: view.rightAnchor),
      
    ])
        
    daybutton.backgroundColor = .cyan
    daybutton.setTitle("Add Day", for: .normal)
    daybutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    daybutton.frame = CGRect(x: 280, y: 680, width: 100, height: 100)
        daybutton.backgroundColor = UIColor.brown
    //daybutton.translatesAutoresizingMaskIntoConstraints = false
        Firestore.firestore().collection("Data").addSnapshotListener {
                    snapshot, error in
                    if error != nil {
                        print(error)
                }
                var time = [Days]()
                for document in snapshot!.documents {
                    let data = document.data()
                    time.append(
                        Days (
                            dayname:data ["dayname"] as! Timestamp
                        //attandance:data ["data"] as! Bool,
                       //absent:data ["data"] as! Bool,
                    )
                )
                }
                days = time
                self.tableview.reloadData()
                }
   
        NSLayoutConstraint.activate([
      daybutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
    ])
 
  }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return days.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
     //let cell = tableView.dequeueReusableCell(withIdentifier:"DaysCell", for: indexPath) as! "DaysCell"
   let cell = tableView.dequeueReusableCell(withIdentifier: DaysCell.identefier, for: indexPath) as! DaysCell
      
      let some = days[indexPath.row]
      let date = (some.dayname.dateValue())
      //cell.textLabel?.text = "\(data.dayname)"
      //cell.studentlable.text = "\(data.dayname)"
      // cell.backgroundColor = .cyan
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      //formatter.dateFormat = .medium
      formatter.dateFormat = "EEEE,MM d, yyyy"
      let resultDate = formatter.string(from: date)
      cell.studentlable.text = resultDate

    return cell
  }
    
  
    @objc func buttonAction(sender: UIButton) {
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
    let myDatePicker: UIDatePicker = UIDatePicker()
      myDatePicker.timeZone = .autoupdatingCurrent
      myDatePicker.preferredDatePickerStyle = .wheels
      myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
      let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
      alertController.view.addSubview(myDatePicker)
      let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
          
          var ref: DocumentReference? = nil
          ref = self.db.collection("Date").addDocument(data: [
            "data": myDatePicker.date
          ]) { error in
                if let error = error {
                  print("Error adding document: \(error)")
                } else {
                  print("Document added with ID: \(ref!.documentID)")
               
                }
            }
          print("select Date:\(myDatePicker.date)")
                  self.tableview.reloadData()
             })
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(selectAction)
      alertController.addAction(cancelAction)
      present(alertController, animated: true)
}
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
let AttendanceSheet = AttandanceController()
    (AttandanceController().self, animated: true)
}
