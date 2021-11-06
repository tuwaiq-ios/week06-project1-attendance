//
//  DaysList.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 29/03/1443 AH.
//

import UIKit



class Days:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let BtnAdd = UIButton()
        
        view.addSubview(BtnAdd)
        
        BtnAdd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BtnAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        BtnAdd.backgroundColor = .orange
        // BtnAdd.addTarget(self, action: #selector(a), for: .touchUpInside)
        BtnAdd.backgroundColor = UIColor.red
        BtnAdd.setTitle("Add days", for: .normal)
        
        BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(BtnAdd)
        
    }
    @objc func buttonAction(sender: UIButton!) {
        present(MViewController(), animated: true, completion: nil)
    
}
}
    
   
