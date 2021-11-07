//
//  AppDelegate.swift
//  AttendanceApp
//
//  Created by Amal on 28/03/1443 AH.
//

import Foundation
import UIKit

extension UILabel {
    func setupLabel(with textColor: UIColor) {
        font = UIFont.systemFont(ofSize: 29, weight: .bold)
        self.textColor = textColor
    }
}
extension UIButton {
    func circularButton() {
        setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium)), for: .normal)
        layer.cornerRadius = 65 / 2
        clipsToBounds = true
        backgroundColor = .black.withAlphaComponent(0.9)
    }
}

