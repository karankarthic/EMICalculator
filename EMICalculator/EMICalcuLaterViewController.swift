//
//  EMICalcuLaterViewController.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import UIKit

class EMICalcuLaterViewController:UIViewController{
    
    lazy var principalLable = ViewFactory.titleLable()
    lazy var intrestLable = ViewFactory.titleLable()
    lazy var tenureLable = ViewFactory.titleLable()
    
    lazy var principalField = ViewFactory.textField()
    lazy var intrestField = ViewFactory.textField()
    lazy var tenureField = ViewFactory.textField()
    
    lazy var tenureChoiceSecment = ViewFactory.returnTenureChoiceSegment()
    
    lazy var wholeWrapper = ViewFactory.stackView()
    
    lazy var calculateButton:UIButton = {
        let button = ViewFactory.button()
        button.setTitle("Calculate", for: .normal)
        button.backgroundColor = .orange
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        return button
    }()
    
    lazy var resetButton:UIButton = {
        let button = ViewFactory.button()
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .separator
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return button
    }()
    
    var dataSource:EMICalculaterDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
}

extension EMICalcuLaterViewController{
    
    private func constructPrincipalLayout() -> UIView{
         
         let wrapper = ViewFactory.wrapperView()
         
         principalLable.text = "Principal"
         principalField.placeholder = "Enter the Principal"
         
         principalLable.backgroundColor = .gray
         principalLable.layer.cornerRadius = 10
         
         let constructedLayout = ConstructFieldsUiniqueLayout(titleLable: principalLable, valueTextField: principalField)
         constructedLayout.constructLayoutForContainerView(wrapper)
         
         return wrapper
     }
     
    private func constructIntresrLayout() -> UIView{
         
         let wrapper = ViewFactory.wrapperView()
         
         intrestLable.text = "Interest"
         intrestField.placeholder = "Enter the Interest % "
         
         let constructedLayout = ConstructFieldsUiniqueLayout(titleLable: intrestLable, valueTextField: intrestField)
         constructedLayout.constructLayoutForContainerView(wrapper)
         
         return wrapper
     }
    
    private func constructTenurelayout() -> UIView{
        
        let tenureValueEnteringView = constructTenureEnteringView()
        
        let wrapper = ViewFactory.stackView()
        wrapper.axis = .horizontal
        wrapper.alignment = .center
        wrapper.distribution = .fillProportionally
        wrapper.spacing = 10
        
        wrapper.addArrangedSubview(tenureValueEnteringView)
        
        tenureChoiceSecment.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return wrapper
    }
    
     
    private func constructTenureEnteringView() -> UIView{
         
         let wrapper = ViewFactory.wrapperView()
         
         tenureLable.text = "Tenture"
         tenureField.placeholder = "Enter the Tenture"
         
         let constructedLayout = ConstructFieldsUiniqueLayout(titleLable: tenureLable, valueTextField: tenureField)
         constructedLayout.constructLayoutForContainerView(wrapper)
         
         return wrapper
     }
    
    private func setUpView(){
        
        wholeWrapper.axis = .vertical
        wholeWrapper.alignment = .center
        wholeWrapper.distribution = .fillEqually
        wholeWrapper.spacing = 20
        
        self.view.addSubview(wholeWrapper)
        
        wholeWrapper.addArrangedSubview(constructPrincipalLayout())
        wholeWrapper.addArrangedSubview(constructIntresrLayout())
        wholeWrapper.addArrangedSubview(constructTenureEnteringView())
        wholeWrapper.addArrangedSubview(tenureChoiceSecment)
        wholeWrapper.addArrangedSubview(calculateButton)
        wholeWrapper.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            self.wholeWrapper.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            self.wholeWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.wholeWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        
    }
    
}

/// Mark :- objc methods to add for targets
extension EMICalcuLaterViewController{
    
    @objc private func calculate(){
        
        let principal = Double(principalField.text ?? "0") ?? 0
        let interest = Double(intrestField.text ?? "0") ?? 0
        let tenure = Double(tenureField.text ?? "0") ?? 0
        
        let tenureValue:Double
        
        if tenureChoiceSecment.selectedSegmentIndex == 0{
            tenureValue = tenure
        }else{
            tenureValue = (tenure/12)
        }
        
        self.dataSource.updateValue(valuesForEMICalcus: .init(principal: principal, interest: interest, tenure: tenureValue))
        
        print(dataSource.emiPerMonth())
        
    }
    
    @objc private func reset(){
        principalField.text = ""
        intrestField.text = ""
        tenureField.text = ""
        
        self.dataSource.updateValue(valuesForEMICalcus: .init(principal: 0, interest: 0, tenure: 0))
        self.view.endEditing(true)
    }
    
    
    
}

