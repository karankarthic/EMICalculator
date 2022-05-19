//
//  EMICalculaterDataSource.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 13/05/22.
//

import Foundation

struct EMITableChartValue{
    let month:String
    let paidPrincipal:Double
    let intrestPaid:Double
    let balncePrincipal:Double

    func returnArrayOFValues()->[Any]{
        let mirror = Mirror(reflecting: self)
        var result: [Any] = []
        for (_, value) in mirror.children {
            
            result.append(value)
        }
        
        return result
    }
    
}

struct EMITableChartValues{
    var values:[EMITableChartValue]
}

enum TenureType {
    case month
    case year
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
    
    func counstructValuesForEMITable() -> EMITableChartValues{
        
        var values:EMITableChartValues = .init(values: [])
        let monthlyEMI = calculateTheEMI().rounded()
        
        var principal = self.principal.rounded()
        
        let tenureCout = Int(((tenure) * 12) + 1)
        for count in 0..<(tenureCout){
            
            let eachMontIntreset = getMonthlyIntrest(principal: principal).rounded()
            
            let principalPaidPerMonth = (monthlyEMI - eachMontIntreset).rounded()
            
            if principal > principalPaidPerMonth{
            
            principal = (principal - principalPaidPerMonth).rounded()
                
            }else{
                principal = (principalPaidPerMonth - principal).rounded()
            }
            
            let now = Date()
            let calendar = Calendar.current

            var monthName = ""
            if let then = calendar.date(byAdding: .month, value: (count + 1), to: now) {
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "MMM-YY"
              monthName = dateFormatter.string(from: then)
            }
            
            let value = EMITableChartValue(month: monthName, paidPrincipal: principalPaidPerMonth, intrestPaid: eachMontIntreset, balncePrincipal: principal)
            
            values.values.append(value)
        }
        
        return values
        
    }
    
    private func getMonthlyIntrest(principal:Double) ->Double{
        return (calculatePercentage(value: principal, percentageVal: self.interest) / 12)
    }
    
    private func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
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
    
    func getEmiChartvalues() -> EMITableChartValues{
        
       return data.counstructValuesForEMITable()
    }
    
    func totalEmiInterest() -> Double{
        
        return data.totalInterestToPay()
    }
    
}
