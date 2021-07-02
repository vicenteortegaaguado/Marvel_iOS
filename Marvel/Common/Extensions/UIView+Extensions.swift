//
//  UIView+Extensions.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

// MARK: - Constraints

extension UIView {

    func setConstraintsFillToSafeArea(top: CGFloat = 0.0, leading: CGFloat = 0.0, trailing: CGFloat = 0.0, bottom: CGFloat = 0.0) {
        guard let superview = superview else {
            fatalError("Not found ancestor in view hierarchy")
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
        ])
    }
    
    func setConstraintsFillToSuperview(top: CGFloat = 0.0, leading: CGFloat = 0.0, trailing: CGFloat = 0.0, bottom: CGFloat = 0.0) {
        guard let superview = superview else {
            fatalError("Not found ancestor in view hierarchy")
        }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom)
        ])
    }
}

// MARK: - Shadow

extension UIView {
    
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 8
    }
}
