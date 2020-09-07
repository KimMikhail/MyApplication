//
//  MyButton.swift
//  Pref
//
//  Created by  Mikhail on 15.07.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import UIKit
import AVFoundation

class MyButton: UIButton {

        var audioPlayer = AVAudioPlayer()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            customizeButton(self)
            soundInitialize()
            
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            customizeButton(self)
            soundInitialize()
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
    
        
    func customizeButton(_ button: UIButton) {
        button.layer.backgroundColor = #colorLiteral(red: 0.1935304999, green: 0.3249722719, blue: 0.4246627688, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            button.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        button.clipsToBounds = false
            button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 8
        button.layer.frame.origin.x = 900
        
        button.layer.cornerRadius = 8
        superview?.bringSubviewToFront(self)
    }
    


}

extension MyButton {
    
    private func soundInitialize(){
        let sound = Bundle.main.path(forResource: "click", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("sound error")
        }
    }
}
