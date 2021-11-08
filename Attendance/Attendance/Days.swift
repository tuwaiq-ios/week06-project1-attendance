//
//  Days.swift
//  AttendanceApp
//


import UIKit


class DateList : UIViewController , UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateP.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell",for: indexPath) as! CellDays
        let listdays = dateP[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        cell.Label8.text = formatter.string(from: listdays.date)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dd = dateP[indexPath.row]
        
        
        
        self.present(PrsentPage(), animated: true, completion: nil)
    }
    
    
    
    let TV = UITableView()
    let BtnAdd = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TV.delegate = self
        TV.dataSource = self
        
        TV.translatesAutoresizingMaskIntoConstraints = false
        TV.register(CellDays.self, forCellReuseIdentifier: "cell")
        view.addSubview(TV)
        
        NSLayoutConstraint.activate([
            TV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            TV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            TV.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            TV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(BtnAdd)
        
        NSLayoutConstraint.activate([
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        BtnAdd.backgroundColor = .orange
        BtnAdd.backgroundColor = UIColor.blue
        BtnAdd.setTitle("Add Day", for: .normal)
        BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(BtnAdd)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let secondController = MViewController()
        secondController.callbackClosure = { [weak self] in
            
            self?.TV.reloadData()
        }
        present(secondController, animated: true, completion: nil)
        
    }
    
}

class CellDays: UITableViewCell {
    
    let Label8 = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        
        
        Label8.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(Label8)
        NSLayoutConstraint.activate([
            Label8.centerYAnchor.constraint(equalTo: centerYAnchor),
            Label8.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
