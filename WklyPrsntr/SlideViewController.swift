//
//  ViewController.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 09.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import UIKit

protocol Indexable {
    var pageIndex: Int! { get set }
}

enum ColorMode {
    case bright
    case dark
    
    var backgroundColor: UIColor {
        switch self {
        case .bright:
            return .white
        case .dark:
            return .black
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .bright:
            return .black
        case .dark:
            return .white
        }
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

class SlideViewController: UIViewController, Indexable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: CountDownButton!
    @IBOutlet weak var progressView: ProgressRingView!

    var pageIndex: Int!
    
    var countDown: CountDown?
    var topic: Topic!
    var colorMode: ColorMode! {
        didSet {
            view.backgroundColor = colorMode.backgroundColor
            progressView.backgroundColor = colorMode.backgroundColor
            nameLabel.textColor = colorMode.textColor
            timerLabel.textColor = colorMode.textColor
            topicLabel.textColor = colorMode.textColor
        }
    }
    
    fileprivate func setOutlets() {
        topicLabel.text = topic.title
        nameLabel.text = topic.presenter
        nameLabel.underline()
        timerLabel.text = CountDown.timeFormatted(topic.secondos)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
        countDown = CountDown(time: topic.secondos) { [unowned self] (time) in
            self.timerLabel.text = CountDown.timeFormatted(time)
            self.progressView.progress = CGFloat(time / self.topic.secondos)
            if time == 0.0 {
                self.startStopButton.buttonState = .start
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let timer = countDown else {
            return
        }
        if timer.state == .counting {
            timer.endTimer()
        }
    }
    
    @IBAction func toggleAction(_ sender: CountDownButton) {
        switch sender.buttonState {
        case .start:
            countDown?.startTimer()
        case .stop:
            countDown?.endTimer()
        }
        sender.buttonState = sender.buttonState.opposite
    }
}
