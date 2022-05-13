//
//  UiViewExtentions.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import UIKit

extension UIView {
    
    func addBorder(edge: UIRectEdge, color: UIColor? = UITableView().separatorColor, borderWidth: CGFloat = 0.5) {
        var borderSize = borderWidth
        if #available(iOS 10.0, *) {} else {
            borderSize = 1
        }
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(seperator)
        seperator.backgroundColor = color
        if edge == .top || edge == .bottom {
            seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            seperator.heightAnchor.constraint(equalToConstant: borderSize).isActive = true
            if edge == .top {
                seperator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }
            else {
                seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        } else if edge == .left || edge == .right {
            seperator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            seperator.widthAnchor.constraint(equalToConstant: borderSize).isActive = true
            if edge == .left {
                seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            }
            else {
                seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            }
        }
    }
    
    func fillSuperView(with inset: UIEdgeInsets = UIEdgeInsets.zero)
    {
        if let superview = self.superview
        {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset.left),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset.bottom),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset.right)
                ])
        }
    }
    
}


