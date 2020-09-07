//
//  ResultsViewController.swift
//  Pref
//
//  Created by  Mikhail on 19.07.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var firstName = ""
    var secondName = ""
    var thirdName = ""
    var fourthName = ""
    
    var firstScore = ""
    var secondScore = ""
    var thirdScore = ""
    var fourthScore = ""
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var fourthNameLabel: UILabel!
    
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var thirdScoreLabel: UILabel!
    @IBOutlet weak var fourthScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = firstName
        secondNameLabel.text = secondName
        thirdNameLabel.text = thirdName
        
        firstScoreLabel.text = firstScore
        secondScoreLabel.text = secondScore
        thirdScoreLabel.text = thirdScore
        
        if fourthName != "" {
            fourthNameLabel.text = fourthName
            fourthScoreLabel.text = fourthScore
        } else {
            fourthNameLabel.isHidden = true
            fourthScoreLabel.isHidden = true
        }
      
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
