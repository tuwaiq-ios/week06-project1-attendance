//
//  StudenrVC.swift
//  attendace11
//
//  Created by Macbook on 02/04/1443 AH.
//

import UIKit

import FirebaseFirestore
import Firebase




class StudentsVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    let BtnAdd = UIButton()
    let TV1 = UITableView()
    var Addnews : Array<Students> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TV1.dataSource = self
        TV1.delegate = self
        
        
        TV1.register(Cell.self, forCellReuseIdentifier: "cell")
        TV1.backgroundColor = .white
        TV1.rowHeight = 80
        TV1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TV1)
        NSLayoutConstraint.activate([
            TV1.leftAnchor.constraint(equalTo: view.leftAnchor),
            TV1.rightAnchor.constraint(equalTo: view.rightAnchor),
            TV1.topAnchor.constraint(equalTo: view.topAnchor),
            TV1.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
        ])
        view.addSubview(BtnAdd)
        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        //BtnAdd.backgroundColor = .orange
        // BtnAdd.addTarget(self, action: #selector(a), for: .touchUpInside)
        BtnAdd.backgroundColor = UIColor.gray
        BtnAdd.setTitle("Add Student ", for: .normal)
        BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(BtnAdd)
        
        Firestore.firestore().collection("Students").addSnapshotListener { snapshot , error in
            if error != nil {
                print (error)
                return
            }
            
            var stArr = [Students]()
            for document in snapshot!.documents {
                let data = document.data()
                stArr.append(Students(name: data ["name"] as! String
                                     )
                )
        }
            self.Addnews = stArr
            self.TV1.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addnews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = Addnews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! Cell
        cell.namecell.text = "\(contact.name)"
        
        return cell
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let secondController = AddStudent()
        secondController.callbackClosure = { [weak self] in
            
            self?.TV1.reloadData()
        }
        present(secondController, animated: true, completion: nil)
        //navigationController?.pushViewController(secondController, animated: true)
        //present(AddStudent(), animated: true, completion: nil)
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


