//
//  StudentsList.swift
//  AttendanceApp
//


import UIKit

import FirebaseFirestore
import Firebase

struct ContactsData {
    var nameContact: String
}
var Addn : Array<Students> = []

class StudentsList: UIViewController , UITableViewDataSource, UITableViewDelegate {
    let BtnAdd = UIButton()
    var tabelView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(Cell.self, forCellReuseIdentifier: "cell")
        tabelView.backgroundColor = .white
        tabelView.rowHeight = 80
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabelView)
        NSLayoutConstraint.activate([
            tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabelView.topAnchor.constraint(equalTo: view.topAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
        ])
        view.addSubview(BtnAdd)
        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        BtnAdd.backgroundColor = .orange
        BtnAdd.backgroundColor = UIColor.blue
        BtnAdd.setTitle("Add Student ", for: .normal)
        BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(BtnAdd)
        
        Firestore.firestore().collection("students").addSnapshotListener { snapshot,error in
            if error != nil {
                print (error)
                return
            }
            
            for document in snapshot!.documents{
                let data = document.data()
                Addn.append(Students(name: data["name"] as! String))
            }
        }
        self.tabelView.reloadData()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete") { _, _, _ in
                Addn.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = Addn[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! Cell
        cell.namecell.text = "\(contact.name)"
        
        return cell
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let secondController = AddStudent()
        secondController.callbackClosure = { [weak self] in
            
            self?.tabelView.reloadData()
        }
        present(secondController, animated: true, completion: nil)
    
    }
    
}

class Cell: UITableViewCell {
    
    let namecell = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        namecell.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(namecell)
        NSLayoutConstraint.activate(
            [namecell.centerYAnchor.constraint(equalTo: centerYAnchor),
             namecell.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
