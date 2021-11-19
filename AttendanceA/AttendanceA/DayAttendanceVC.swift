

import UIKit

class DayAttendanceVC: UIViewController {

	var dayId: String
	let cellId = "StudentAttendanceCell"
	var day: Day?
	var students: Array<Student> = []
	
	init (dayId: String) {
		self.dayId = dayId
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.dayId = ""
		super.init(coder: coder)
	}
	
	lazy var studentsTV: UITableView = {
		let tv = UITableView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.delegate = self
		tv.dataSource = self
        tv.register(Cell3.self, forCellReuseIdentifier: Cell3.identifire)
		return tv
	}()
	lazy var pStudentsLabel = UILabel()
	lazy var aStudentsLabel = UILabel()
  
    
	lazy var labelStack: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			pStudentsLabel, aStudentsLabel
		])
		sv.translatesAutoresizingMaskIntoConstraints = false
		
		return sv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        aStudentsLabel.backgroundColor =  UIColor(red: (95/255), green: (120/255), blue: (113/255), alpha: 1)
        pStudentsLabel.backgroundColor = UIColor(red: (95/255), green: (120/255), blue: (113/255), alpha: 1)
     
        aStudentsLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        pStudentsLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        aStudentsLabel.textColor = .white
        pStudentsLabel.textColor = .white
        labelStack.layer.cornerRadius = 40
        
        DaysVC.shared.listenToDay(dayId: dayId) { newDay in
			self.day = newDay
			self.title = newDay?.styleDate()
			self.updateViews()
		}
		
        StudentsVC.shared.listenToStudents { newStudents in
			self.students = newStudents
			self.updateViews()
		}
		
		view.backgroundColor = .white
		
		view.addSubview(labelStack)
		NSLayoutConstraint.activate([
            
            
			labelStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
			labelStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			labelStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            labelStack.widthAnchor.constraint(equalToConstant: 60),
            labelStack.heightAnchor.constraint(equalToConstant: 60),
		])
		
		view.addSubview(studentsTV)
		NSLayoutConstraint.activate([
            
            studentsTV.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
			studentsTV.leftAnchor.constraint(equalTo: view.leftAnchor),
			studentsTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            
			studentsTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
	func checkStudentPresent(studentId: String) -> Bool {
		return day?.pStudents.contains(studentId) ?? false
	}
	
	func getPStudentsCount() -> Int {
        return day?.pStudents.count ?? 0
	}
	
	func getAStudentsCount() -> Int {
		let pStudentsCount = getPStudentsCount()
		return (students.count - pStudentsCount)
	}
//    (pStudentsCount - students.count)
	
	func updateViews() {
		studentsTV.reloadData()
		pStudentsLabel.text = "Present: \(getPStudentsCount())"
		aStudentsLabel.text = "Apsent: \(getAStudentsCount())"
	}
}

extension DayAttendanceVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return students.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell3.identifire, for: indexPath) as! Cell3
        cell.backgroundColor =  UIColor(red: (221/255), green: (237/255), blue: (233/255), alpha: 1)
        
     
		let student = students[indexPath.row]
		cell.label5.text = student.name
    
		
		let isStudentPresent = checkStudentPresent(studentId: student.id)
		if isStudentPresent {
            
            

            
                cell.label6.text = "Present"
            cell.label6.textColor = .systemGreen
        } else {
            

            
                cell.label6.text = "Apsent"
            cell.label6.textColor = .red
		}
	
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
		let student = students[indexPath.row]
		
		DaysVC.shared.switchStudentStatus(
			day: day!,
			studentId: student.id
		)
        
     
        tableView.reloadData()
	}
	
	
}


class Cell3: UITableViewCell {
    
  
    
    
    static let identifire = "cell"
    
    public let label5: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    
    public let label6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        //
        return label
    }()
    
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        contentView.backgroundColor = .purple
        
        contentView.addSubview(label5)
        contentView.addSubview(label6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        label5.frame = CGRect(x: 30,
                              y: 5,
                              width: 260,
                              height: contentView.frame.size.height-10)
        
        label6.frame = CGRect(x: 300,
                              //                                up or down
                              y: 5,
                              width: 90,
                              height: contentView.frame.size.height-10)
        
    }
    
}



