//
//  ViewController.swift
//  Flashcards
//
//  Created by Andrew Kelly on 10/13/18.
//  Copyright © 2018 Andrew Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
   // @IBOutlet weak var card: UIView!
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.layer.cornerRadius = 20.0
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.5
      //  questionLabel.layer.shadowRadius = 15.0
      //  answerLabel.layer.shadowRadius = 15.0
        
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapOnFlashCard(_ sender: Any) {
        if (answerLabel.isHidden == true){
            answerLabel.isHidden = false
        }
        else if (answerLabel.isHidden == false){
            answerLabel.isHidden = true
        }
    }
    func updateFlashcard(question: String, answer: String)  {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

