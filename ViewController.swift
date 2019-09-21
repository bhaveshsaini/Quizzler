//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var counter = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nextQuestion()
        progressLabel.text = "\(counter + 1) / 13"
        scoreLabel.text = "Score: " + String(score)
    }


    @IBAction func answerPressed(_ sender: AnyObject)
    {
        if sender.tag == 1
        {
            pickedAnswer = true
        }
        
        else if sender.tag == 2
        {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI()
    {
        scoreLabel.text = "Score: " + String(score)
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(counter + 1)
    }
    

    func nextQuestion()
    {
        
        if counter < 13
        {
            let question = allQuestions.list[counter]
            progressLabel.text = "\(counter + 1) / 13"
            questionLabel.text = question.questionText
        }
        
        else
        {
            let alert = UIAlertController(title: "End of Quiz", message: "You have completed the quiz", preferredStyle: .alert)
            
            let restart = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restart)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer()
    {
        let answer = allQuestions.list[counter]
        if answer.answer == pickedAnswer
        {
            ProgressHUD.showSuccess("Correct")
            counter += 1
            score += 1
            updateUI()
            nextQuestion()
        }
        
        else
        {
            ProgressHUD.showError("Wrong")
            counter += 1
            nextQuestion()
        }
    }
    
    
    func startOver()
    {
        counter = 0
        score = 0
        progressLabel.text = "\(counter + 1) / 13"
        updateUI()
        nextQuestion()
        scoreLabel.text = "Score: " + String(0)
    }
}
