//
//  EMITableCell.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 16/05/22.
//

import UIKit

class EMITableCell:UITableViewCell{
    
    lazy private var monthLable:UILabel = ViewFactory.titleLable()
    lazy private var paidPrincipalLable:UILabel = ViewFactory.titleLable()
    lazy private var intrestPaidLable:UILabel = ViewFactory.titleLable()
    lazy private var balancePrincipalLable:UILabel = ViewFactory.titleLable()
    
    lazy private var wrapperView:UIStackView = ViewFactory.stackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    func configureCellValues(value:EMITableChartValue){
        
        monthLable.text = value.month
        paidPrincipalLable.text = "\(value.paidPrincipal)"
        intrestPaidLable.text = "\(value.intrestPaid)"
        balancePrincipalLable.text = "\(value.balncePrincipal)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension EMITableCell{
    
    private func setUpView(){
        
        let layout = EMITableCellAndHeaderLayOut.init(monthLable: monthLable, paidPrincipalLable: paidPrincipalLable, intrestPaidLable: intrestPaidLable, balancePrincipalLable: balancePrincipalLable)
        layout.constructLayoutForContainerView(self.contentView)
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



