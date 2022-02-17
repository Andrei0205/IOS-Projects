//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var choiceButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score:\(quizBrain.getScore())"
        populatingButtons()
        updateQuestionText()
    }

    @IBAction func butonPressed(_ sender: UIButton) {
        populatingButtons()
        let currentAnswer = sender.currentTitle!
        let userGotRight = quizBrain.checkAnswer(currentAnswer)
        
        
        if userGotRight{
            sender.backgroundColor = UIColor.green
        }else {
            sender.backgroundColor = UIColor.red
        }
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateQuestionText), userInfo: nil, repeats: false)
        
        quizBrain.nextQuestion()
       
        
        scoreLabel.text = "Score:\(quizBrain.getScore())"
        
    }
    
    @objc func updateQuestionText() {
        questionLabel.text = quizBrain.getNextQuestionText()
        progressBar.progress = quizBrain.progressBar()
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        choiceButton.backgroundColor = UIColor.clear
        
        
    }
    func populatingButtons() {
        trueButton.setTitle(quizBrain.showPossibleAnswers(numberOfAnswer: 0), for: UIControl.State.normal)
        falseButton.setTitle(quizBrain.showPossibleAnswers(numberOfAnswer: 1), for: UIControl.State.normal)
        choiceButton.setTitle(quizBrain.showPossibleAnswers(numberOfAnswer: 2), for: UIControl.State.normal)
    }

}

