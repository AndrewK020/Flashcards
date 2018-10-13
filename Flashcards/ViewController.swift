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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

