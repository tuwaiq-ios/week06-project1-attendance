//
//  Custom.swift
//  AttendanceApp
//
//  Created by fatimah  on 30/03/1443 AH.
//

import Foundation
import UIKit

extension UILabel {
    func setupLabel(with textColor: UIColor) {
        font = UIFont.systemFont(ofSize: 31, weight: .bold)
        self.textColor = textColor
    }
}
extension UIButton {
    func circularButton() {
        setImage(UIImage(systemName: "plus")?.withTintColor(.systemGray , renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
        layer.cornerRadius = 65 / 2
        clipsToBounds = true
        backgroundColor = .systemIndigo.withAlphaComponent(0.9)
    }
}

