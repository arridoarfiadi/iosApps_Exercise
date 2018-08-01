//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank().getQuestionBank()
    var questionNum = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        var pickedAnswer = false
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2{
            pickedAnswer = false
        }
        checkAnswer(pickedAnswer)
    }
    
    
    func updateUI() {
        questionLabel.text = allQuestions[questionNum].questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNum + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNum + 1)
    }
    

    func nextQuestion() {
        if questionNum + 1 >= allQuestions.count {
            let alert = UIAlertController(title: "End of the Quiz", message: "Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
        }
        else{
            questionNum += 1
            
        }
        updateUI()
        
    }
    
    
    func checkAnswer(_ picked: Bool) {
        let correctAnswer = allQuestions[questionNum].getAnswer()
        if correctAnswer == picked{
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else{
            ProgressHUD.showError("Wrong")
        }
        
        nextQuestion()
    }
    
    
    func startOver() {
        questionNum = 0
        score = 0
        updateUI()
        
    }
    

    
}
