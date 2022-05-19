//
//  EMITableCell.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 16/05/22.
//

import UIKit

class EMITableCell:UITableViewCell{
    
    lazy var wrapperView:UIStackView = ViewFactory.stackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    func configureCellValues(value:EMITableChartValue){
        
        for item in value.returnArrayOFValues(){
            
            let titleLable:UILabel = ViewFactory.titleLable()
            titleLable.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            titleLable.text = "\(item)"
            
            wrapperView.addArrangedSubview(titleLable)
           
            
        }
        
        setUpView()
    }
    
    func returnSizeOfStack() -> CGFloat {
        self.layoutIfNeeded()
        return self.wrapperView.frame.width
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension EMITableCell{
    
    private func setUpView(){
        
        self.selectionStyle = .none
        self.contentView.addSubview(wrapperView)
        
        wrapperView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        wrapperView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

    }
}

extension EMITableCell{
    struct ViewFactory{
        
        static func titleLable() ->PaddingLable{
            let lable = PaddingLable()
            lable.translatesAutoresizingMaskIntoConstraints = false
            lable.font = .systemFont(ofSize: 14, weight: .medium)
            lable.textAlignment = .right
            lable.clipsToBounds = true
            lable.lineBreakMode = .byClipping
            lable.backgroundColor = .clear
            return lable
        }
        
        static func stackView()->UIStackView{
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
        }
        
    }
}



