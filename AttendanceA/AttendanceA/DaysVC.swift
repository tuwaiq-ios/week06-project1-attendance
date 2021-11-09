
import Foundation
import UIKit
import FirebaseFirestore

struct Day {
    let id: String
    let timestamp: Timestamp
    var pStudents: Array<String>
    
    func styleDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: timestamp.dateValue())
    }
}
class DaysVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var data = [Day]()
    
	var days: Array<Day> = []
	var studentCount = 0
    
    static let shared = DaysVC()
    
    let daysCollection = Firestore.firestore().collection("days")
    
    
    var dateFormatter: DateFormatter = DateFormatter()
	
	lazy var daysTV: UITableView = {
		let tv = UITableView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.delegate = self
		tv.dataSource = self
//		tv.register(UITableViewCell.self, forCellReuseIdentifier: "DayCell")
        tv.register(Cell.self, forCellReuseIdentifier: Cell.identifire)
		return tv
	}()
	
	lazy var addDayButton: UIButton = {
		let b = UIButton()
		b.addTarget(self, action: #selector(AddDay), for: .touchUpInside)
		b.translatesAutoresizingMaskIntoConstraints = false
		b.setTitle("Add Day", for: .normal)
		b.backgroundColor = UIColor(red: (10/255), green: (47/255), blue: (67/255), alpha: 1)
        b.layer.cornerRadius = 25
		return b
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        DaysVC.shared.listenToDays { newDays in
			self.days = newDays
			self.daysTV.reloadData()
		}
        StudentsVC.shared.listenToStudentCount { newStudentCount in
			self.studentCount = newStudentCount
			self.daysTV.reloadData()
		}
		
		tabBarItem = UITabBarItem(title: "Days", image: UIImage(systemName: "calendar"), selectedImage: nil)
		view.backgroundColor = .gray
		
		view.addSubview(daysTV)
		NSLayoutConstraint.activate([
			daysTV.topAnchor.constraint(equalTo: view.topAnchor),
			daysTV.leftAnchor.constraint(equalTo: view.leftAnchor),
			daysTV.rightAnchor.constraint(equalTo: view.rightAnchor),
			daysTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		
		view.addSubview(addDayButton)
        NSLayoutConstraint.activate([
            addDayButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addDayButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addDayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            addDayButton.widthAnchor.constraint(equalToConstant: 400),
            addDayButton.heightAnchor.constraint(equalToConstant: 60),
        ])
	}
	

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifire, for: indexPath) as! Cell
//
            let day = days[indexPath.row]
            let pStudentCount = day.pStudents.count
            let aStudentCount = (studentCount -  pStudentCount)
//        cell.backgroundColor = .red
            cell.label2.text = day.styleDate()
            cell.label3.text = "P: \(pStudentCount)"
            cell.label4.text = " A: \(aStudentCount)"
      
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        
        let navigationController = UINavigationController(
            rootViewController: DayAttendanceVC(dayId: day.id)
        )
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
    
    @objc func AddDay(){

        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        
        myDatePicker.timeZone = .autoupdatingCurrent
        
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
        
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
             
                
                let date = myDatePicker.date
                let uuid = UUID().uuidString
                
                DaysVC.shared.addDay(
                    day: Day(
                        id: uuid,
                        timestamp: Timestamp(date: date),
                        pStudents: []
                    )
                )
//                let date = myDatePicker.date
                self.data.append(Day(id: "",
                                     timestamp: Timestamp(date: date),
                                     pStudents: []))
//
                     print(self.data)
                     print("Selected Date: \(myDatePicker.date)")
              
                
                 self.daysTV.reloadData()
              
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)

    }
    
    func listenToDay(dayId: String, completion: @escaping ((Day?) -> Void)) {
        daysCollection.document(dayId).addSnapshotListener { document, error in
            if error != nil {
                completion(nil)
                return
            }
            guard let data = document?.data() else {
                completion(nil)
                return
            }
            
            let day = Day(
                id: (data["id"] as? String) ?? "No id",
                timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                pStudents: (data["pStudents"] as? [String]) ?? []
            )
            completion(day)
        }
    }
    
    func addDay(day: Day) {
        daysCollection.document(day.id).setData([
            "timestamp": day.timestamp,
            "id": day.id,
            "pStudents": day.pStudents,
        ])
    }
    
    
    
    func deleteDay(dayId: String) {
        daysCollection.document(dayId).delete()
    }
    
    func listenToDays(completion: @escaping (([Day]) -> Void)) {
        daysCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            var days: Array<Day> = []
            for document in documents {
                let data = document.data()
                let day = Day(
                    id: (data["id"] as? String) ?? "No id",
                    timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                    pStudents: (data["pStudents"] as? [String]) ?? []
                )
                days.append(day)
            }
            completion(days)
        }
    }
    
    func switchStudentStatus(day: Day, studentId: String) {
        let isStudentPresent = day.pStudents.contains(studentId)
        
        if isStudentPresent {
            let newPStudents = day.pStudents.filter { id in id != studentId }
            
            daysCollection.document(day.id).updateData([
                "pStudents": newPStudents
            ])
        } else {
            var newPStudents = day.pStudents
            newPStudents.append(studentId)
            
            daysCollection.document(day.id).updateData([
                "pStudents": newPStudents
            ])
        }
    }

}



class Cell: UITableViewCell {
    
    static let identifire = "cell"
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      cell.backgroundColor = .yellow

     }
   

 public let label2: UILabel = {
      let label = UILabel()
     label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
      label.textColor = UIColor(red: (10/255), green: (47/255), blue: (67/255), alpha: 1)
      return label
    }()
    
  
    public let label3: UILabel = {
         let label = UILabel()
         label.text = "a"
         label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
         label.textColor = UIColor(red: (10/255), green: (47/255), blue: (67/255), alpha: 1)
 //
         return label
       }()
    
    public let label4: UILabel = {
         let label = UILabel()
         label.text = "b"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
         label.textColor = UIColor(red: (10/255), green: (47/255), blue: (67/255), alpha: 1)

         return label
       }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(label4)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()


        label2.frame = CGRect(x: 18,
                              y: 5,
                              width: 260,
                              height: contentView.frame.size.height-10)
// x: right-left
        label3.frame = CGRect(x: 300,
//                                up or down
                              y: 5,
                              width: 70,
                              height: contentView.frame.size.height-10)
        
        label4.frame = CGRect(x: 350,
                              y: 5,
                              width: 70,
                              height: contentView.frame.size.height-10)
        
    }

}
