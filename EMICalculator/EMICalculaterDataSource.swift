//
//  EMICalculaterDataSource.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import Foundation


struct EMITableChartValue{
    
}

struct ValuesForEMICalcus {
    var principal:Double
    var interest:Double
    var tenure:Double
    
    
    func calculateTheEMI() -> Double{
        
        
        let  LoanAmount : Double = self.principal //loan amount
        let  InterestRate: Double = self.interest //interest rate
        let   NumberOfYears: Double = self.tenure //number of years

        let   interestRateDecimal: Double = InterestRate / (12 * 100)
        let   months: Double = NumberOfYears * 12
        let   rPower: Double = pow(1+interestRateDecimal,months)

        let  monthlyPayments: Double = LoanAmount * interestRateDecimal * rPower / (rPower - 1)
//        let  totalPayments: Double = monthlyPayments * months
//        let  yearlyPayments: Double = monthlyPayments * 12
//        let  totalInterest: Double = totalPayments - LoanAmount
        
        return monthlyPayments
    }
    
    func totalInterestToPay() -> Double{
        
        return (totalAmoutToSettel() - principal)
    }
    
    func totalAmoutToSettel() -> Double{
        
        let  months: Double = self.tenure * 12
        let monthylyPayments = calculateTheEMI()
        
        return (monthylyPayments * months)
    }
    
    mutating func initWithDefalutData(){
        principal = 0
        interest = 0
        tenure = 0
    }
}


class EMICalculaterDataSource{
    
    var data = ValuesForEMICalcus.init(principal: 0, interest: 0, tenure: 0)
    
    init(){
        self.data.initWithDefalutData()
    }
    
    func updateValue(valuesForEMICalcus:ValuesForEMICalcus){
        self.data = valuesForEMICalcus
    }
    
    func returnTotalAmoutToPay() -> Double{
        
        return data.totalAmoutToSettel().rounded()
    }
    
    func emiPerMonth() -> Double{
        
        return data.calculateTheEMI().rounded()
    }
    
    func totalEmiInterest() -> Double{
        
        return data.totalInterestToPay()
    }
    
}
