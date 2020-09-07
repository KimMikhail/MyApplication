//
//  ScoreViewController.swift
//  Pref
//
//  Created by  Mikhail on 25.06.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import UIKit
import AVFoundation

let defaults = UserDefaults.standard
class ScoreViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    
    var firstResumeScore : Int = -1
    var secondResumeScore : Int = -1
    var thirdResumeScore : Int = -1
    var fourthResumeScore : Int = -1
    
    var wistingPlayer: Int = 1
    
    @IBOutlet weak var firstPlayerView: UIView!
    @IBOutlet weak var secondPlayerView: UIView!
    @IBOutlet weak var thirdPlayerView: UIView!
    @IBOutlet weak var fourthPlayerView: UIView!
    
    @IBOutlet weak var fourthMountButton: UIButton!
    @IBOutlet weak var fourthBulletButton: UIButton!
    

    @IBOutlet weak var mainMenuButton: UIButton!
    
    
    
    @IBOutlet weak var firstPlayerButton: UIButton!
    @IBOutlet weak var secondPlayerButton: UIButton!
    @IBOutlet weak var thirdPlayerButton: UIButton!
    @IBOutlet weak var fourthPlayerButton: UIButton!
    
    @IBOutlet weak var firstPlayerWistButton: UIButton!
     @IBOutlet weak var secondPlayerWistButton: UIButton!
     @IBOutlet weak var thirdPlayerWistButton: UIButton!
    @IBOutlet weak var fourthPlayerWistButton: UIButton!
    
    var firstScore = 0 {
        didSet {
            self.firstPlayerScore.text = "\(self.firstScore)"
        }
    }
    var secondScore = 0 {
        didSet {
            secondPlayerScore.text = "\(secondScore)"
        }
    }
    var thirdScore = 0 {
        didSet {
            thirdPlayerScore.text = "\(thirdScore)"
        }
    }
    var fourthScore = 0 {
        didSet {
            fourthPlayerScore.text = "\(fourthScore)"
        }
    }
    
    var playersCount: Int = 3
    var selectedPlayer: Int = 0
    var MountBullet: Bool = true


    
    @IBOutlet var viewStack: [UIView]!
    @IBOutlet weak var firstPlayer: UILabel!
    @IBOutlet weak var secondPlayer: UILabel!
    @IBOutlet weak var thirdPlayer: UILabel!
    @IBOutlet weak var fourthPlayer: UILabel!
    
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var betView: UIView!
    @IBOutlet weak var betButton: UIButton!
    
    @IBOutlet  weak var firstPlayerScore: UILabel!
    @IBOutlet  weak var secondPlayerScore: UILabel!
    @IBOutlet  weak var thirdPlayerScore: UILabel!
    @IBOutlet  weak var fourthPlayerScore: UILabel!
    
    @IBOutlet weak var wistView: UIView!
    @IBOutlet weak var wistOkButton: UIButton!
    @IBOutlet weak var wistTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSound()
        
        if firstResumeScore != -1 {
            firstScore = firstResumeScore
        }
        if secondResumeScore != -1 {
            secondScore = secondResumeScore
        }
        if thirdResumeScore != -1 {
            thirdScore = thirdResumeScore
        }
        
        if fourthResumeScore != -1 {
            fourthScore = fourthResumeScore
        }
        
        if playersCount == 3 {

            fourthPlayerView.removeFromSuperview()
            fourthPlayerView.backgroundColor = .none
            fourthPlayer.isHidden = true
            fourthPlayerScore.isHidden = true
            fourthMountButton.isHidden = true
            fourthBulletButton.isHidden = true
            fourthPlayerWistButton.isHidden = true
            
            
        }
        
        wistView.isHidden = true
        
        firstPlayer.text = first
        secondPlayer.text = second
        thirdPlayer.text = third
        fourthPlayer.text = fourth

        firstScore = firstResumeScore == -1 ? 0 : firstResumeScore
        secondScore = secondResumeScore == -1 ? 0 : secondResumeScore
        thirdScore = thirdResumeScore == -1 ? 0 : thirdResumeScore
        if playersCount == 4 {
        fourthScore = fourthResumeScore == -1 ? 0 : fourthResumeScore
        }
        
        
        betView.layer.borderWidth = 1.5
        betView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        betView.layer.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.3215686275, blue: 0.4156862745, alpha: 1)
        betView.alpha = 0.95
        betView.layer.cornerRadius = 15
        betView.isHidden = true
        betButton.isEnabled = false
        
        wistView.layer.borderWidth = 1.5
        wistView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        wistView.isHidden = true
        wistView.layer.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.3215686275, blue: 0.4156862745, alpha: 1)
        wistView.alpha = 0.95
        wistView.layer.cornerRadius = 15
        wistOkButton.isEnabled = false

        
        for view in viewStack {
            view.layer.cornerRadius = 10
        }
        

        
        betTextField.addTarget(self, action: #selector(betTextFieldObserver), for: .editingChanged)
        wistTextField.addTarget(self, action: #selector(wistTextFieldObserver), for: .editingChanged)
        
        firstPlayerButton.isHidden = true
        secondPlayerButton.isHidden = true
        thirdPlayerButton.isHidden = true
        fourthPlayerButton.isHidden = true
        
        mainMenuButtonCustomization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveDefaults()
        
    }
    
    private func saveDefaults() {
        defaults.set(firstPlayer.text, forKey: "firstplayername")
        defaults.set(firstScore, forKey: "firstscore")
        
        
        defaults.set(secondPlayer.text, forKey: "secondplayername")
        defaults.set(secondScore, forKey: "secondscore")
        
        defaults.set(thirdPlayer.text, forKey: "thirdplayername")
        defaults.set(thirdScore, forKey: "thirdscore")
        
        if playersCount == 4 {
        defaults.set(fourthPlayer.text, forKey: "fourthplayername")
            defaults.set(fourthScore, forKey: "fourthscore")
        }
        
        defaults.set(playersCount, forKey: "playerscount")
    }
    
    
    @IBAction func mountBulletButtonsTapped(_ button: UIButton) {
        switch button.restorationIdentifier {
               case "firstMount":
                   selectedPlayer = 1
                   MountBullet = true
               case "secondMount":
                   selectedPlayer = 2
                   MountBullet = true
               case "thirdMount":
                   selectedPlayer = 3
                   MountBullet = true
               case "fourthMount":
                   selectedPlayer = 4
                   MountBullet = true
               case "firstBullet":
                   selectedPlayer = 1
                   MountBullet = false
               case "secondBullet":
                   selectedPlayer = 2
                   MountBullet = false
               case "thirdBullet":
                   selectedPlayer = 3
                   MountBullet = false
               case "fourthBullet":
                   selectedPlayer = 4
                   MountBullet = false
               default:
                   print("default case")
               }
            betView.isHidden = false
            for view in viewStack {
                view.alpha = 0.5
            }
        playersViewsUserInteractionToggle()
    }
    
    @IBAction func buttonTapped(_ button: UIButton) {
        switch (MountBullet) {
        case (false):
            switch (selectedPlayer, playersCount) {
            case (1, 3):
                firstScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                secondScore -= Int(button.restorationIdentifier!)! * 10
                thirdScore -= Int(button.restorationIdentifier!)! * 10
            case (2, 3):
                firstScore -= Int(button.restorationIdentifier!)! * 10
                secondScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                thirdScore -= Int(button.restorationIdentifier!)! * 10
            case (3, 3):
                firstScore -= Int(button.restorationIdentifier!)! * 10
                secondScore -= Int(button.restorationIdentifier!)! * 10
                thirdScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
            case (1, 4):
                firstScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                secondScore -= Int(button.restorationIdentifier!)! * 10
                thirdScore -= Int(button.restorationIdentifier!)! * 10
                fourthScore -= Int(button.restorationIdentifier!)! * 10
            case (2, 4):
                firstScore -= Int(button.restorationIdentifier!)! * 10
                secondScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                thirdScore -= Int(button.restorationIdentifier!)! * 10
                fourthScore -= Int(button.restorationIdentifier!)! * 10
            case (3, 4):
                firstScore -= Int(button.restorationIdentifier!)! * 10
                secondScore -= Int(button.restorationIdentifier!)! * 10
                thirdScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                fourthScore -= Int(button.restorationIdentifier!)! * 10
            case (4, 4):
                firstScore -= Int(button.restorationIdentifier!)! * 10
                secondScore -= Int(button.restorationIdentifier!)! * 10
                thirdScore -= Int(button.restorationIdentifier!)! * 10
                fourthScore += Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
            default:
                print("default case")
            }
        case (true):
            switch (selectedPlayer, playersCount) {
            case (1, 3):
                firstScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                secondScore += Int(button.restorationIdentifier!)! * 10
                thirdScore += Int(button.restorationIdentifier!)! * 10
            case (2, 3):
                firstScore += Int(button.restorationIdentifier!)! * 10
                secondScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                thirdScore += Int(button.restorationIdentifier!)! * 10
            case (3, 3):
                firstScore += Int(button.restorationIdentifier!)! * 10
                secondScore += Int(button.restorationIdentifier!)! * 10
                thirdScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
            case (1, 4):
                firstScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                secondScore += Int(button.restorationIdentifier!)! * 10
                thirdScore += Int(button.restorationIdentifier!)! * 10
                fourthScore += Int(button.restorationIdentifier!)! * 10
            case (2, 4):
                firstScore += Int(button.restorationIdentifier!)! * 10
                secondScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                thirdScore += Int(button.restorationIdentifier!)! * 10
                fourthScore += Int(button.restorationIdentifier!)! * 10
            case (3, 4):
                firstScore += Int(button.restorationIdentifier!)! * 10
                secondScore += Int(button.restorationIdentifier!)! * 10
                thirdScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
                fourthScore += Int(button.restorationIdentifier!)! * 10
            case (4, 4):
                firstScore += Int(button.restorationIdentifier!)! * 10
                secondScore += Int(button.restorationIdentifier!)! * 10
                thirdScore += Int(button.restorationIdentifier!)! * 10
                fourthScore -= Int(button.restorationIdentifier!)! * 10 * (playersCount - 1)
            default:
                print("default case")
            }
        
        }
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
        
        let betAnimation = BetAnimation(frame: CGRect(x: view.frame.width / 2 - 60, y: view.frame.height / 2 - 180, width: 120, height: 80))
        
        betAnimation.font.withSize(60)
        view.addSubview(betAnimation)
        betAnimation.animate(mountBullet: MountBullet,text: button.restorationIdentifier!)
        saveDefaults()
        playersViewsUserInteractionToggle()
    }
    
    @IBAction func wistButtonTapped(_ button: UIButton) {
        switch playersCount {
        case 3:
            switch button.restorationIdentifier {
            case "firstWist":
             selectedPlayer = 1
             firstPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
             firstPlayerView.isUserInteractionEnabled = false
             
             secondPlayerView.layer.borderWidth = 5
             secondPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             secondPlayerButton.isHidden = false
             secondPlayerView.isUserInteractionEnabled = false
             secondPlayerWistButton.isEnabled = false
             
             thirdPlayerView.layer.borderWidth = 5
             thirdPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             thirdPlayerButton.isHidden = false
             thirdPlayerView.isUserInteractionEnabled = false
             thirdPlayerWistButton.isEnabled = false
             
            case "secondWist":
                selectedPlayer = 2
                secondPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                secondPlayerView.isUserInteractionEnabled = false
                
                firstPlayerView.layer.borderWidth = 5
                firstPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                firstPlayerButton.isHidden = false
                firstPlayerView.isUserInteractionEnabled = false
                firstPlayerWistButton.isEnabled = false
                
                thirdPlayerView.layer.borderWidth = 5
                thirdPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                thirdPlayerButton.isHidden = false
                thirdPlayerView.isUserInteractionEnabled = false
                thirdPlayerWistButton.isEnabled = false
    
            case "thirdWist":
                selectedPlayer = 3
                thirdPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                thirdPlayerView.isUserInteractionEnabled = false
                
                firstPlayerView.layer.borderWidth = 5
                firstPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                firstPlayerView.isUserInteractionEnabled = false
                firstPlayerButton.isHidden = false
                firstPlayerWistButton.isEnabled = false
                
                secondPlayerView.layer.borderWidth = 5
                secondPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                secondPlayerView.isUserInteractionEnabled = false
                secondPlayerButton.isHidden = false
                secondPlayerWistButton.isEnabled = false

            default:
                print("default case")
            }
        case 4:
            switch button.restorationIdentifier {
            case "firstWist":
             selectedPlayer = 1
             firstPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
             firstPlayerView.isUserInteractionEnabled = false
             
             secondPlayerView.layer.borderWidth = 5
             secondPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             secondPlayerButton.isHidden = false
             secondPlayerView.isUserInteractionEnabled = false
             secondPlayerWistButton.isEnabled = false
             
             thirdPlayerView.layer.borderWidth = 5
             thirdPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             thirdPlayerButton.isHidden = false
             thirdPlayerView.isUserInteractionEnabled = false
             thirdPlayerWistButton.isEnabled = false
             
             fourthPlayerView.layer.borderWidth = 5
             fourthPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             fourthPlayerButton.isHidden = false
             fourthPlayerView.isUserInteractionEnabled = false
             fourthPlayerWistButton.isEnabled = false
             
            case "secondWist":
                selectedPlayer = 2
                secondPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                secondPlayerView.isUserInteractionEnabled = false
                
                firstPlayerView.layer.borderWidth = 5
                firstPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                firstPlayerButton.isHidden = false
                firstPlayerView.isUserInteractionEnabled = false
                firstPlayerWistButton.isEnabled = false
                
                thirdPlayerView.layer.borderWidth = 5
                thirdPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                thirdPlayerButton.isHidden = false
                thirdPlayerView.isUserInteractionEnabled = false
                thirdPlayerWistButton.isEnabled = false
                
                fourthPlayerView.layer.borderWidth = 5
                fourthPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                fourthPlayerButton.isHidden = false
                fourthPlayerView.isUserInteractionEnabled = false
                fourthPlayerWistButton.isEnabled = false
               
            case "thirdWist":
                selectedPlayer = 3
                thirdPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                thirdPlayerView.isUserInteractionEnabled = false
                
                firstPlayerView.layer.borderWidth = 5
                firstPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                firstPlayerView.isUserInteractionEnabled = false
                firstPlayerButton.isHidden = false
                firstPlayerWistButton.isEnabled = false
                
                secondPlayerView.layer.borderWidth = 5
                secondPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                secondPlayerView.isUserInteractionEnabled = false
                secondPlayerButton.isHidden = false
                secondPlayerWistButton.isEnabled = false
                
                fourthPlayerView.layer.borderWidth = 5
                fourthPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                fourthPlayerButton.isHidden = false
                fourthPlayerView.isUserInteractionEnabled = false
                fourthPlayerWistButton.isEnabled = false
                
            case "fourthWist":
                selectedPlayer = 4
                fourthPlayerView.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                fourthPlayerView.isUserInteractionEnabled = false
                
                firstPlayerView.layer.borderWidth = 5
                firstPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                firstPlayerView.isUserInteractionEnabled = false
                firstPlayerButton.isHidden = false
                firstPlayerWistButton.isEnabled = false
                
                secondPlayerView.layer.borderWidth = 5
                secondPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                secondPlayerView.isUserInteractionEnabled = false
                secondPlayerButton.isHidden = false
                secondPlayerWistButton.isEnabled = false
                
                thirdPlayerView.layer.borderWidth = 5
                thirdPlayerView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                thirdPlayerButton.isHidden = false
                thirdPlayerView.isUserInteractionEnabled = false
                thirdPlayerWistButton.isEnabled = false
            default:
                print("default case")
            }
            
        default:
            print("default case")
        }
               
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        audioPlayer.play()
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
        playersViewsUserInteractionToggle()
    }
    
    
    @IBAction func betButtonTapped(_ button: UIButton) {
        audioPlayer.play()
        if playersCount == 4 && !MountBullet{
        switch selectedPlayer {
        case 1:
            firstScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
            secondScore -= Int(betTextField.text!)! * 10
            thirdScore -= Int(betTextField.text!)! * 10
            fourthScore -= Int(betTextField.text!)! * 10
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
            selectedPlayer = 0
        case 2:
        firstScore -= Int(betTextField.text!)! * 10
        secondScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
        thirdScore -= Int(betTextField.text!)! * 10
        fourthScore -= Int(betTextField.text!)! * 10
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
        case 3:
        firstScore -= Int(betTextField.text!)! * 10
        secondScore -= Int(betTextField.text!)! * 10
        thirdScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
        fourthScore -= Int(betTextField.text!)! * 10
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
        case 4:
        firstScore -= Int(betTextField.text!)! * 10
        secondScore -= Int(betTextField.text!)! * 10
        thirdScore -= Int(betTextField.text!)! * 10
        fourthScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
            
        default:
            print("default case")
        
        }
        } else if playersCount == 3 && !MountBullet {
            switch selectedPlayer {
            case 1:
                firstScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
                secondScore -= Int(betTextField.text!)! * 10
                thirdScore -= Int(betTextField.text!)! * 10
                selectedPlayer = 0
                betView.isHidden = true
                for view in viewStack {
                    view.alpha = 1
                }
                selectedPlayer = 0
            case 2:
            firstScore -= Int(betTextField.text!)! * 10
            secondScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
            thirdScore -= Int(betTextField.text!)! * 10
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
                selectedPlayer = 0
            case 3:
            firstScore -= Int(betTextField.text!)! * 10
            secondScore -= Int(betTextField.text!)! * 10
            thirdScore += Int(betTextField.text!)! * 10 * (playersCount - 1)
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
                selectedPlayer = 0
            
            default:
                print("default case")
            
            }
            
        } else if playersCount == 4 && MountBullet{
        switch selectedPlayer {
        case 1:
            firstScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
            secondScore += Int(betTextField.text!)! * 10
            thirdScore += Int(betTextField.text!)! * 10
            fourthScore += Int(betTextField.text!)! * 10
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
            selectedPlayer = 0
        case 2:
        firstScore += Int(betTextField.text!)! * 10
        secondScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
        thirdScore += Int(betTextField.text!)! * 10
        fourthScore += Int(betTextField.text!)! * 10
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
        case 3:
        firstScore += Int(betTextField.text!)! * 10
        secondScore += Int(betTextField.text!)! * 10
        thirdScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
        fourthScore += Int(betTextField.text!)! * 10
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
        case 4:
        firstScore += Int(betTextField.text!)! * 10
        secondScore += Int(betTextField.text!)! * 10
        thirdScore += Int(betTextField.text!)! * 10
        fourthScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
        selectedPlayer = 0
        betView.isHidden = true
        for view in viewStack {
            view.alpha = 1
        }
            selectedPlayer = 0
            
        default:
            print("default case")
        
        }
        } else if playersCount == 3 && MountBullet{
            switch selectedPlayer {
            case 1:
                firstScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
                secondScore += Int(betTextField.text!)! * 10
                thirdScore += Int(betTextField.text!)! * 10
                selectedPlayer = 0
                betView.isHidden = true
                for view in viewStack {
                    view.alpha = 1
                }
                selectedPlayer = 0
            case 2:
            firstScore += Int(betTextField.text!)! * 10
            secondScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
            thirdScore += Int(betTextField.text!)! * 10
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
                selectedPlayer = 0
            case 3:
            firstScore += Int(betTextField.text!)! * 10
            secondScore += Int(betTextField.text!)! * 10
            thirdScore -= Int(betTextField.text!)! * 10 * (playersCount - 1)
            selectedPlayer = 0
            betView.isHidden = true
            for view in viewStack {
                view.alpha = 1
            }
                selectedPlayer = 0
            
            default:
                print("default case")
            
            }
            
            
        }
        // TO DO: textfield animation
        let betAnimation = BetAnimation(frame: CGRect(x: view.frame.width / 2 - 60, y: view.frame.height / 2 - 180, width: 120, height: 80))
        
        betAnimation.font.withSize(60)
        view.addSubview(betAnimation)
        betAnimation.animate(mountBullet: MountBullet,text: betTextField.text!)
        betTextField.endEditing(true)
        betTextField.text?.removeAll()
        saveDefaults()
        button.isEnabled = false
        playersViewsUserInteractionToggle()
    }
    
    @IBAction func chooseWistButtonTapped(_ button: UIButton) {
        view.bringSubviewToFront(wistView)
        audioPlayer.play()
        wistView.isHidden = false
            switch button.restorationIdentifier {
            case "firstChooseWist":
                wistingPlayer = 1
            case "secondChooseWist":
                wistingPlayer = 2
            case "thirdChooseWist":
                wistingPlayer = 3
            case "fourthChooseWist":
                wistingPlayer = 4
            default:
                print("default case")
            }
    }
    
    @objc private func betTextFieldObserver() {
        if let _ = Int(betTextField.text!) {
            betButton.isEnabled = true
        } else {
            betButton.isEnabled = false
        }
        
    }
    
    @objc private func wistTextFieldObserver() {
        if let _ = Int(wistTextField.text!) {
            wistOkButton.isEnabled = true
        } else {
            wistOkButton.isEnabled = false
        }
    }
     
    @IBAction func wistBetButtonsTapped(_ button: UIButton){

        switch button.restorationIdentifier {
        case "four":
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + 4)"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - 4)"
            wistView.isHidden = true

        case "six":
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + 6)"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - 6)"
            wistView.isHidden = true

        case "eight":
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + 8)"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - 8)"
            wistView.isHidden = true

        case "ten":
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + 10)"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - 10)"
            wistView.isHidden = true

        case "twelve":
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + 12)"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - 12)"
            wistView.isHidden = true

        case "OkWist":
            audioPlayer.play()
            definingPlayer().0.text = "\(Int(definingPlayer().0.text!)! + (Int(wistTextField.text!) ?? 0))"
            definingPlayer().1.text = "\(Int(definingPlayer().1.text!)! - (Int(wistTextField.text!) ?? 0))"
            wistView.isHidden = true
            wistTextField.endEditing(true)
            button.isEnabled = false
        case "closeButton":
            audioPlayer.play()
            print("close button tapped")
        default:
            print("default case")
        }
        
        let betAnimation = BetAnimation(frame: CGRect(x: view.frame.width / 2 - 60, y: view.frame.height / 2 - 180, width: 120, height: 80))
        betAnimation.font.withSize(60)
        view.addSubview(betAnimation)
        view.bringSubviewToFront(betAnimation)
        if button.restorationIdentifier == "OkWist" {
            betAnimation.animate(mountBullet: false,text: wistTextField!.text!)
        } else if button.restorationIdentifier != "closeButton" {
            betAnimation.animate(mountBullet: false,text: button.titleLabel!.text!)
        }
        
        standartOptions()
        saveDefaults()
        
    }
    
    private func definingPlayer() ->(UILabel, UILabel) {
        var currentPlayer = firstPlayerScore
        var wistPlayer = firstPlayerScore
        
        switch selectedPlayer {
        case 1:
            currentPlayer = firstPlayerScore
        case 2:
            currentPlayer = secondPlayerScore
        case 3:
            currentPlayer = thirdPlayerScore
        case 4:
            currentPlayer = fourthPlayerScore
        default:
            print("default case")
        }
        
        switch wistingPlayer {
        case 1:
            wistPlayer = firstPlayerScore
        case 2:
            wistPlayer = secondPlayerScore
        case 3:
            wistPlayer = thirdPlayerScore
        case 4:
            wistPlayer = fourthPlayerScore
        default:
            print("default case")
        }
        return (currentPlayer!, wistPlayer!)
    }
    
    private func standartOptions() {
        wistTextField.text = ""
        betTextField.text = ""
        wistView.isHidden = true
        betView.isHidden = true
        // first
        firstPlayerView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        firstPlayerView.isUserInteractionEnabled = true
        firstPlayerButton.isEnabled = true
        firstPlayerWistButton.isEnabled = true
        firstPlayerView.layer.borderWidth = 0
        firstScore = Int(firstPlayerScore.text!)!
        firstPlayerButton.isHidden = true
        
        secondPlayerView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        secondPlayerView.isUserInteractionEnabled = true
        secondPlayerButton.isEnabled = true
        secondPlayerWistButton.isEnabled = true
        secondPlayerView.layer.borderWidth = 0
        secondScore = Int(secondPlayerScore.text!)!
        secondPlayerButton.isHidden = true
        
        thirdPlayerView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        thirdPlayerView.isUserInteractionEnabled = true
        thirdPlayerButton.isEnabled = true
        thirdPlayerWistButton.isEnabled = true
        thirdPlayerView.layer.borderWidth = 0
        thirdScore = Int(thirdPlayerScore.text!)!
        thirdPlayerButton.isHidden = true
        
        
        if playersCount == 4{
            
        fourthPlayerView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        fourthPlayerView.isUserInteractionEnabled = true
        fourthPlayerButton.isEnabled = true
        fourthPlayerWistButton.isEnabled = true
        fourthPlayerView.layer.borderWidth = 0
        fourthScore = Int(fourthPlayerScore.text!)!
        fourthPlayerButton.isHidden = true
            
        }
        
    }
    
    @IBAction func cancelMenuAcion(_ sender: Any) {
        audioPlayer.play()
        
        let alertController = UIAlertController(title: "menu", message: "", preferredStyle: .alert)
        let mainMenuAction = UIAlertAction(title: "back to main", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        let clearScoreAction = UIAlertAction(title: "restart", style: .default) { (_) in
            self.firstScore = 0
            self.secondScore = 0
            self.thirdScore = 0
            self.fourthScore = 0
        }
        let resultAction = UIAlertAction(title: "results", style: .default) { (_) in
            self.performSegue(withIdentifier: "ShowResults", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive)
        alertController.addAction(mainMenuAction)
        alertController.addAction(clearScoreAction)
        alertController.addAction(resultAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func mainMenuButtonCustomization() {
        mainMenuButton.layer.cornerRadius = mainMenuButton.layer.frame.height / 2
        mainMenuButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mainMenuButton.layer.borderWidth = 1.5
    }
    
    private func playersViewsUserInteractionToggle() {
        firstPlayerView.isUserInteractionEnabled.toggle()
        secondPlayerView.isUserInteractionEnabled.toggle()
        thirdPlayerView.isUserInteractionEnabled.toggle()
        if playersCount == 4 {
            fourthPlayerView.isUserInteractionEnabled.toggle()
        }
    }

}
// MARK: Text Field Delegate
extension ScoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        betTextField.endEditing(true)
        wistTextField.endEditing(true)
    }
}

//MARK: Navigation

extension ScoreViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainScreen" {
            let mainVC = segue.destination as! NameViewController
            mainVC.toggleTextFields()
        }
        if segue.identifier == "ShowResults" {
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.firstName = first
            resultsVC.secondName = second
            resultsVC.thirdName = third
            
            resultsVC.firstScore = "\(firstScore)"
            resultsVC.secondScore = "\(secondScore)"
            resultsVC.thirdScore = "\(thirdScore)"
            
            if playersCount == 4 {
                resultsVC.fourthName = fourth
                resultsVC.fourthScore = "\(fourthScore)"
            }
            
        }
    }
}

// MARK: Bet Animation

extension ScoreViewController {
    class BetAnimation: UILabel {
        override init(frame: CGRect) {
                super .init(frame: frame)
            let font = UIFont(name: "Didot", size: 40)
            self.font = font
            self.autoresizesSubviews = true
            }
            required init?(coder: NSCoder) {
                super .init(coder: coder)
            }
            
        
            
        func animate(mountBullet: Bool, text: String) {
            
                self.textAlignment = .center
                self.textColor = mountBullet ? #colorLiteral(red: 1, green: 0.26033777, blue: 0.325165242, alpha: 1) : #colorLiteral(red: 0.675470233, green: 0.8723731637, blue: 0.9572706819, alpha: 1)
                self.text = text

                UIView.animate(withDuration: 0.5, delay: 0.0,
                           options: [.curveEaseInOut],
                           animations: { () -> Void in
                            
                            self.transform = CGAffineTransform(scaleX: 7, y: 7)
                            self.transform = CGAffineTransform.identity

                    
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.removeFromSuperview()
                }
                
                
            }
    }
}

// MARK: Buttons audio
extension ScoreViewController {
    
    private func initializeSound(){
        let sound = Bundle.main.path(forResource: "click", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("sound error")
        }
    }
}






