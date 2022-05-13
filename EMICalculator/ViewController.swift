//
//  ViewController.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 12/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    func emiCalculator(la :Double,ir:Double,noy:Double){
        
        let  LoanAmount : Double = la; //loan amount
        let  InterestRate: Double = ir; //interest rate
        let   NumberOfYears: Double = noy; //number of years

        let   interestRateDecimal: Double = InterestRate / (12 * 100);
        let    months: Double = NumberOfYears * 12;
        let   rPower: Double = pow(1+interestRateDecimal,months);

        let  monthlyPayments: Double = LoanAmount * interestRateDecimal * rPower / (rPower - 1);
        let  totalPayments: Double = monthlyPayments * months;
        let  yearlyPayments: Double = monthlyPayments * 12;
        let  totalInterest: Double = totalPayments - LoanAmount;
        
        print((totalInterest).rounded())
        print((monthlyPayments).rounded())
        print((totalPayments).rounded())
    }

}

