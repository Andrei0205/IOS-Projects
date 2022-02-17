//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Andrei Marinescu on 19.03.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI (height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        if bmiValue < 18 {
            bmi = BMI(value: bmiValue, advice: "eat more pieces", color: .blue)
        } else if bmiValue < 24 {
            bmi = BMI(value: bmiValue, advice: "stay fitted", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "eat less pieces", color: .red)
        }
        
    }
    
    func getBMIValue() -> String {
        let bmiValue = String(format: "%.2f", bmi?.value ?? 0.0)
        return bmiValue
    }
    func getBMIColor() -> UIColor {
        return bmi?.color ?? .black
    }
    func getBMIAdvice() -> String {
        return bmi?.advice ?? "incorrect"
    }
    
}
