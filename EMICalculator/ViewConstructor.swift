//
//  ViewConstructor.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import UIKit

struct ConstructFieldsUiniqueLayout{
    
    let titleLable : UIView
    let valueTextField : UIView
    
    func constructLayoutForContainerView(_ containerView : UIView)
    {
        titleLable.backgroundColor = .gray
        titleLable.layer.cornerRadius = 10
        
        containerView.addSubview(titleLable)
        containerView.addSubview(valueTextField)
        
        valueTextField.addBorder(edge: .bottom,color: .black)
        
        NSLayoutConstraint.activate([
            titleLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                              constant: 17),
            titleLable.widthAnchor.constraint(equalToConstant: 100),
            titleLable.heightAnchor.constraint(equalToConstant: 30),
            
            valueTextField.heightAnchor.constraint(equalToConstant: 30),
            valueTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            valueTextField.leadingAnchor.constraint(equalTo: titleLable.trailingAnchor,
                                               constant: 10),
            valueTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                constant: -10),
        ])
    }
}

struct EMITableCellAndHeaderLayOut{
    
    var monthLable:UIView
    var paidPrincipalLable:UIView
    var intrestPaidLable:UIView
    var balancePrincipalLable:UIView
    
    var wrapperView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    func constructLayoutForContainerView(_ containerView : UIView){
        
        containerView.addSubview(wrapperView)
        
        wrapperView.addArrangedSubview(monthLable)
        wrapperView.addArrangedSubview(paidPrincipalLable)
        wrapperView.addArrangedSubview(intrestPaidLable)
        wrapperView.addArrangedSubview(balancePrincipalLable)
        
        wrapperView.fillSuperView()
        
    }
    
}

