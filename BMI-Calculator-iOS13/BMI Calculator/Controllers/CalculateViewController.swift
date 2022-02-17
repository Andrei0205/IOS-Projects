//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
     
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightSlider.value = 1.5
        weightSlider.value = 100
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSlider(_ sender: UISlider) {
        
        let height = "\(String(format: "%.2f", sender.value))m"
        heightLabel.text = height
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        let weight = "\(String(format: "%.0f", sender.value))Kg"
        weightLabel.text = weight
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        let weight = weightSlider.value
        let height = heightSlider.value
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.view.backgroundColor = calculatorBrain.getBMIColor()
            destinationVC.adviceLabel.text = calculatorBrain.getBMIAdvice()
            
        }
    }

}
