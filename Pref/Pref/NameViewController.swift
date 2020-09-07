//
//  NameViewController.swift
//  Pref
//
//  Created by  Mikhail on 25.06.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    

    
    @IBOutlet weak var firstPlayerName: UITextField!
    @IBOutlet weak var secondPlayerName: UITextField!
    @IBOutlet weak var thirdPlayerName: UITextField!
    @IBOutlet weak var fourthPlayerName: UITextField!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstPlayerName.delegate = self
        firstPlayerName.returnKeyType = .next
        secondPlayerName.delegate = self
        secondPlayerName.returnKeyType = .next
        thirdPlayerName.delegate = self
        thirdPlayerName.returnKeyType = .next
        fourthPlayerName.delegate = self
        fourthPlayerName.returnKeyType = .done
        
        okButton.alpha = 0.7
        okButton.isEnabled = false
        
        resumeButton.isEnabled = defaults.accessibilityElementCount() <= 0
        firstPlayerName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        secondPlayerName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        thirdPlayerName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        fourthPlayerName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        toggleTextFields()
        
    }
    
    @IBAction func resumeButtonAction() {
        
    }
    
    @IBAction func newGameButtonAction(_ sender: Any) {
    
        okButton.isEnabled = false
        okButton.alpha = 0.7
        toggleTextFields()
        toggleButtons()
        firstPlayerName.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        toggleTextFields()
        toggleButtons()
        firstPlayerName.text?.removeAll()
        secondPlayerName.text?.removeAll()
        thirdPlayerName.text?.removeAll()
        fourthPlayerName.text?.removeAll()
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreSegue" {
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.first = firstPlayerName.text!
            scoreVC.second = secondPlayerName.text!
            scoreVC.third = thirdPlayerName.text!
            
            if fourthPlayerName.text != nil && fourthPlayerName.text != "" {
                scoreVC.fourth = fourthPlayerName.text!
                scoreVC.playersCount = 4
            } else {
                scoreVC.playersCount = 3
            }
            firstPlayerName.text?.removeAll()
            secondPlayerName.text?.removeAll()
            thirdPlayerName.text?.removeAll()
            fourthPlayerName.text?.removeAll()
            toggleTextFields()
            toggleButtons()
        } else {
            let scoreVC = segue.destination as! ScoreViewController
            
            scoreVC.first = defaults.object(forKey: "firstplayername") as! String
            scoreVC.second = defaults.object(forKey: "secondplayername") as! String
            scoreVC.third = defaults.object(forKey: "thirdplayername") as! String
            
            scoreVC.firstResumeScore = defaults.integer(forKey: "firstscore")
            scoreVC.secondResumeScore = defaults.integer(forKey: "secondscore")
            scoreVC.thirdResumeScore = defaults.integer(forKey: "thirdscore")
            scoreVC.fourthResumeScore = -1

            if defaults.object(forKey: "fourthplayername") != nil {
                scoreVC.fourth = defaults.object(forKey: "fourthplayername") as! String
                scoreVC.fourthResumeScore = defaults.integer(forKey: "fourthscore")
            }
            
            scoreVC.playersCount = defaults.integer(forKey: "playerscount")
            
        }

        
    }
    

}

extension NameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstPlayerName {
            textField.resignFirstResponder()
            secondPlayerName.becomeFirstResponder()
        } else if textField == secondPlayerName {
            textField.resignFirstResponder()
            thirdPlayerName.becomeFirstResponder()
        } else if textField == thirdPlayerName {
            textField.resignFirstResponder()
            fourthPlayerName.becomeFirstResponder()
        } else if textField == fourthPlayerName {
            performSegue(withIdentifier: "ScoreSegue", sender: nil)
        }

        return true
    }
    
    @objc private func textFieldChanged() {
        if firstPlayerName.text?.isEmpty == false &&
           secondPlayerName.text?.isEmpty == false &&
           thirdPlayerName.text?.isEmpty == false{
            fourthPlayerName.isHidden = false
            okButton.isEnabled = true
            okButton.alpha = 1
        } else {
            okButton.isEnabled = false
            okButton.alpha = 0.7
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstPlayerName.endEditing(true)
        secondPlayerName.endEditing(true)
        thirdPlayerName.endEditing(true)
        fourthPlayerName.endEditing(true)
    }
    
    
    func toggleTextFields() {
        firstPlayerName.isHidden.toggle()
        secondPlayerName.isHidden.toggle()
        thirdPlayerName.isHidden.toggle()
        fourthPlayerName.isHidden.toggle()
        okButton.isHidden.toggle()
        cancelButton.isHidden.toggle()
    }
    private func toggleButtons() {
        newGameButton.isHidden.toggle()
        resumeButton.isHidden.toggle()
        
    }
    
}



