//
//  CountDown.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 09.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import Foundation
import AVFoundation

extension Array {
    var randomItem: Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

class CountDown {
    var countdownTimer: Timer!
    var totalTime: Double {
        didSet {
            callback(totalTime)
        }
    }
    var callback: (Double) -> Void
    
    init(time: Double, callback: @escaping (Double) -> Void) {
        self.totalTime = time
        self.callback = callback
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTime),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    fileprivate func sayBye() {
        let byes = [
            "tschau tschau tschessko",
            "tschüsli müsli",
            "arividertschi",
            "tschö mit ö"
        ]
        let utterance = AVSpeechUtterance(string: byes.randomItem!)
        utterance.voice = AVSpeechSynthesisVoice.speechVoices().randomItem
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        sayBye()
    }
    
    static func timeFormatted(_ totalSeconds: Double) -> String {
        let seconds: Int = Int(totalSeconds) % 60
        let minutes: Int = Int((totalSeconds) / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

