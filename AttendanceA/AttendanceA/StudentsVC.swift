

import UIKit
import FirebaseFirestore
struct Student {
    let name: String
    let id: String
}


class StudentsVC: UIViewController, UITextFieldDelegate {
//	var students: Array<Student> = []
    var students = [Student]()
    static let shared = StudentsVC()
    let studentsCollection = Firestore.firestore().collection("students")
    
   
    
	lazy var studentsTV: UITableView = {
		let t = UITableView()
		t.translatesAutoresizingMaskIntoConstraints = false
		t.delegate = self
		t.dataSource = self
        t.register(SCell.self, forCellReuseIdentifier: SCell.identifire)
		return t
	}()
	
	lazy var addStudentButton: UIButton = {
		let b = UIButton()
		b.addTarget(self, action: #selector(AddStudent), for: .touchUpInside)
		b.translatesAutoresizingMaskIntoConstraints = false
		b.setTitle("Add Student👩🏻‍💻", for: .normal)
        b.layer.cornerRadius = 25
        
		b.backgroundColor = UIColor(red: (142/255), green: (171/255), blue: (162/255), alpha: 1)
		return b
	}()
    lazy var studentNameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Write student name"
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
    }()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(studentNameTF)
        StudentsVC.shared.listenToStudents { newStudents in
			self.students = newStudents
			self.studentsTV.reloadData()
		}
//        saveText()
		tabBarItem = UITabBarItem(title: "Students", image: UIImage(systemName: "person"), selectedImage: nil)
     
        
		view.backgroundColor = .brown
		
		view.addSubview(studentsTV)
		NSLayoutConstraint.activate([
			studentsTV.topAnchor.constraint(equalTo: view.topAnchor),
			studentsTV.leftAnchor.constraint(equalTo: view.leftAnchor),
			studentsTV.rightAnchor.constraint(equalTo: view.rightAnchor),
			studentsTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		
		view.addSubview(addStudentButton)
        NSLayoutConstraint.activate([
            addStudentButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addStudentButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addStudentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            addStudentButton.widthAnchor.constraint(equalToConstant: 400),
            addStudentButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        
	}
    
    @objc func AddStudent(){
        
        

        let alert = UIAlertController(title: "New Student", message: "Write the name of student", preferredStyle: .alert )
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
           
            let textField = alert.textFields![0] as UITextField
            guard  let text = textField.text, !text.isEmpty else {
                       return
                   }
          
            let name = self.studentNameTF.text!
            let uuid = UUID().uuidString

            StudentsVC.shared.addStudent(
                student: Student(name: textField.text!, id: uuid)
            )
           
            self.students.append(Student(name: textField.text!, id: uuid ))
            
        }
    
        alert.addTextField { (textField) in
            textField.placeholder = "Student name"
            textField.textColor = .purple
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)

    }
    
    func addStudent(student: Student) {
        studentsCollection.document(student.id).setData([
            "name": student.name,
            "id": student.id
        ])
    }
    
    func deleteStudent(studentId: String) {
        studentsCollection.document(studentId).delete()
    }
    
    func listenToStudents(completion: @escaping (([Student]) -> Void)) {
        
        studentsCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            var students: Array<Student> = []
            for document in documents {
                let data = document.data()
                let student = Student(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id"
                )
                students.append(student)
            }
            
            completion(students)
        }
    }
    
    
    
    func listenToStudentCount(completion: @escaping ((Int) -> Void)) {
        listenToStudents { students in
            completion(students.count)
        }
    }
    
}

extension StudentsVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return students.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SCell.identifire, for: indexPath) as! SCell
        
 

        cell.label2.text = students[indexPath.row].name

		return cell
	}
}


class SCell: UITableViewCell {
    
    static let identifire = "StudentCell"

 public let label2: UILabel = {
      let label = UILabel()
     label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
      label.textColor = UIColor(red: (10/255), green: (47/255), blue: (67/255), alpha: 1)
      return label
    }()
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(label2)
      
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

    }

}
