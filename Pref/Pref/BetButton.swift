//
//  BetButton.swift
//  Pref
//
//  Created by  Mikhail on 15.07.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import UIKit
import AVFoundation
class BetButton: UIButton {

    var audioPlayer = AVAudioPlayer()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        soundInitialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customize()
        soundInitialize()
        self.superview?.bringSubviewToFront(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        audioPlayer.play()
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            })
        
    }
    
    private func customize() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.3215686275, blue: 0.4156862745, alpha: 1)
        self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

}


extension BetButton {
    private func soundInitialize(){
        let sound = Bundle.main.path(forResource: "click", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("sound error")
        }
    }
}
