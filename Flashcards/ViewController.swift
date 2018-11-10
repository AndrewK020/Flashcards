//
//  ViewController.swift
//  Flashcards
//
//  Created by Andrew Kelly on 10/13/18.
//  Copyright © 2018 Andrew Kelly. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    
    var flashcards = [Flashcard]()
    
    //current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia")

        
        card.layer.cornerRadius = 20.0
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.5
      
        
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex += 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrement current idex
        currentIndex -= 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
    }
    
    func updateFlashcard(question: String, answer: String)  {
        let flashcard = Flashcard( question: question, answer: answer)
        
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
        
        //adding flashcards to the flashcard array
        flashcards.append(flashcard)
        
        print("#Added a new flashcard.")
        print("#Current flashcard count: \(flashcards.count) ")
        
        //update current index
        currentIndex = flashcards.count - 1
        print("#Current flashcard index: \(currentIndex)")
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        
        // disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        //update previous button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    func saveAllFlashcardsToDisk(){
        
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
            
        }
        
        //save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "Flashcards")
        
        print("Flashcards saved!")
    }
    
    func readSavedFlashcards() {
        
        //read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            //put all the cards into the flashcard array
            flashcards.append(contentsOf: savedCards)
        }
        
    }
}

