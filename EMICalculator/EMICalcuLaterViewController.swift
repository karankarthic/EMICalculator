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
    
    lazy var monthlyEmiLable = ViewFactory.titleLable()
    
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
    
    lazy var presentChartButton:UIButton = {
        let button = ViewFactory.button()
        button.setTitle("EMI Chart", for: .normal)
        button.backgroundColor = .purple
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.addTarget(self, action: #selector(pushEMITable), for: .touchUpInside)
        return button
    }()
    
    var dataSource:EMICalculaterDataSource = .init()
    
    var emiChartValues:EMITableChartValues = .init(values: [])
    
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
        principalField.text = "100000"
         principalLable.layer.cornerRadius = 10
         
         let constructedLayout = ConstructFieldsUiniqueLayout(titleLable: principalLable, valueTextField: principalField)
         constructedLayout.constructLayoutForContainerView(wrapper)
         
         return wrapper
     }
     
    private func constructIntresrLayout() -> UIView{
         
         let wrapper = ViewFactory.wrapperView()
         
         intrestLable.text = "Interest"
        intrestField.text = "10"
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
        tenureField.text = "1"
         tenureField.placeholder = "Enter the Tenture"
         
         let constructedLayout = ConstructFieldsUiniqueLayout(titleLable: tenureLable, valueTextField: tenureField)
         constructedLayout.constructLayoutForContainerView(wrapper)
         
         return wrapper
     }
    
    private func setUpView(){
        
        wholeWrapper.axis = .vertical
        wholeWrapper.alignment = .center
        wholeWrapper.distribution = .fillEqually
        wholeWrapper.spacing = 10
        
        monthlyEmiLable.text = "waiting for calculate"
        monthlyEmiLable.font = .systemFont(ofSize: 30, weight: .medium)
        monthlyEmiLable.textAlignment = .center
        
        self.view.addSubview(wholeWrapper)
        
        wholeWrapper.addArrangedSubview(constructPrincipalLayout())
        wholeWrapper.addArrangedSubview(constructIntresrLayout())
        wholeWrapper.addArrangedSubview(constructTenureEnteringView())
        wholeWrapper.addArrangedSubview(tenureChoiceSecment)
        wholeWrapper.addArrangedSubview(calculateButton)
        wholeWrapper.addArrangedSubview(resetButton)
        wholeWrapper.addArrangedSubview(monthlyEmiLable)
        wholeWrapper.addArrangedSubview(presentChartButton)
        
        
        NSLayoutConstraint.activate([
            self.wholeWrapper.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            self.wholeWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.wholeWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            monthlyEmiLable.heightAnchor.constraint(equalToConstant: 50),
            monthlyEmiLable.widthAnchor.constraint(equalTo: wholeWrapper.widthAnchor)
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
        
        let tenureChoice = tenureChoiceSecment.selectedSegmentIndex
        
        if  tenureChoice == 0{
            tenureValue = tenure
        }else{
            tenureValue = (tenure/12)
        }
        
        self.dataSource.updateValue(valuesForEMICalcus: .init(principal: principal, interest: interest, tenure: tenureValue))
        
        monthlyEmiLable.text = "EMI - RS.\(dataSource.emiPerMonth())"
        
        emiChartValues = dataSource.getEmiChartvalues()
        
    }
    
    @objc private func reset(){
        principalField.text = "100000"
        intrestField.text = "10"
        tenureField.text = "1"
        
        self.dataSource.updateValue(valuesForEMICalcus: .init(principal: 0, interest: 0, tenure: 0))
        self.view.endEditing(true)
    }
    
    @objc private func pushEMITable(){
        
//        if dataSource.data.tenure > 1{
            let Vc = EMITableController(style: .plain)
            Vc.data = emiChartValues
            self.navigationController?.pushViewController(Vc, animated: true)
//        }
        
    }
    
    
    
}

