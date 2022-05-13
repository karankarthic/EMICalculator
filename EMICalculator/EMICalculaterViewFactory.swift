//
//  EMICalculaterViewFactory.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import UIKit


extension EMICalcuLaterViewController{
    struct ViewFactory{
        
        static func wrapperView() -> UIView{
            let wrapperView = UIView()
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            return wrapperView
        }
        
        static func titleLable() ->PaddingLable{
            let lable = PaddingLable()
            lable.translatesAutoresizingMaskIntoConstraints = false
            lable.textAlignment = .left
            lable.layer.cornerRadius = 2
            lable.clipsToBounds = true
            lable.backgroundColor = .clear
            return lable
        }
        
        static func textField() ->UITextField{
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = .systemFont(ofSize: 16, weight: .regular)
            textField.keyboardType = .decimalPad
            textField.textAlignment = .left
//            lable.backgroundColor = .clear
            return textField
        }
        
        
        static func returnTenureChoiceSegment()->UISegmentedControl{
            let items = ["Years","Months"]
            let segmentView = UISegmentedControl(items: items)
            segmentView.translatesAutoresizingMaskIntoConstraints = false
            segmentView.selectedSegmentIndex = 0
            segmentView.tintColor = .black
            return segmentView
        }
        
        static func stackView()->UIStackView{
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }
        
        static func button() -> UIButton  {
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            return button
            
        }
    }
}


class PaddingLable:UILabel{
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10.0, bottom: 10.0, right: 10.0)
        super.drawText(in: rect.inset(by: insets))
    }
}
