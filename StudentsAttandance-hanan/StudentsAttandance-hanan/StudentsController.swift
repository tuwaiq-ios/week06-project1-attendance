//
//  StudentsController.swift
//  StudentsAttandance-hanan
//
//  Created by  HANAN ASIRI on 28/03/1443 AH.
//
import UIKit
import Firebase
import FirebaseFirestore


struct students {
  var name: String?
   var iScompleted = false
}

class StudentsController: UIViewController,UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
    
    var student = [students]()
    let db = Firestore.firestore()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = student[indexPath.row].name
        return cell
    }

    var tableview: UITableView = UITableView()
    let tf = UITextField(frame: CGRect(x: 20, y:100 , width: 300, height: 40))
       let namelabel = UILabel(frame: CGRect(x: 0, y:0 , width: 200, height: 25))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableview)
        self.view.addSubview(tf)
        self.view.addSubview(namelabel)
        
        tableview.backgroundColor = .white
        view.backgroundColor = .lightGray
        tf.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor,constant:150).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tf.placeholder = "Enter text here "
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.keyboardType = UIKeyboardType.default
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.center = CGPoint(x: 160, y: 110)
        
        
        namelabel.center = CGPoint(x: 120, y: 70)
        namelabel.font = UIFont.systemFont(ofSize: 20)
        namelabel.textColor = .brown
        namelabel.textAlignment = .left
        namelabel.text = "Student Name "
       
    let image = UIImage(named: "add")
    let buttone = UIButton(type: UIButton.ButtonType.custom)
    buttone.frame = CGRect(x : 300 , y :80, width :80 , height : 60 )
    buttone.setImage(image, for: .normal)
    buttone.addTarget(self, action: #selector(buttonePressed), for: .touchUpInside)
    
    self.view.addSubview(buttone)
}

@objc func buttonePressed(sender:UIButton) {
    
    if tf.hasText {
        
        let newStudent = students(name: tf.text, iScompleted: false)
        student.insert (newStudent , at: 0)
        
    }
    tf.text = " "
    tf.resignFirstResponder()
        tableview.reloadData()

   //Firestore.firestore().document("students/FirstStudent").setData([
        //"name": tf.text ?? " "
       // ])
    
    var ref: DocumentReference? = nil
          ref = db.collection("users").addDocument(data: [
            "name": tf.text ?? " "
          ]) { err in
            if let err = err {
              print("Error adding document: \(err)")
            } else {
              print("Document added with ID: \(ref!.documentID)")
            }
          }
    tf.text = " "
    tf.resignFirstResponder()
    tableview.reloadData()
    
 
             let alertcontroller = UIAlertController(title: "Alert"
                    , message: "saved data"
                    , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       alertcontroller.addAction(okAction)
              self.present(alertcontroller, animated: true , completion: nil)
       
       
}
        }
