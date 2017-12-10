//
//  AddTopicViewController.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 10.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import UIKit

protocol TopicAddable: class {
    func didCreateTopic(_ topic: Topic)
}

enum UserError: Error {
    case emptyPresenter
    case emptyTitle
}

class AddTopicViewController: UIViewController {
    
    @IBOutlet weak var presenterTextView: UITextField!
    @IBOutlet weak var topicTextView: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var selectedMinutes: Int = 1
    var presenterName: String?
    var topicTitle: String?
    
    weak var delegate: TopicAddable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addTopicAction(_ sender: Any) {
        endEditing()
        guard let presenter = presenterName, let title = topicTitle else {
            return
        }
        let topic = Topic(presenter: presenter, title: title, minutes: Double(selectedMinutes))
        delegate?.didCreateTopic(topic)
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddTopicViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == presenterTextView {
            presenterName = textField.text
        } else {
            topicTitle = textField.text
        }
    }
}

extension AddTopicViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    var minutes: [Int] {
        return Array(1...20)
    }
    
    // MARK: Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(String(describing: minutes[row])) Minuten"
    }
    
    fileprivate func endEditing() {
        topicTextView.endEditing(true)
        presenterTextView.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        endEditing()
        selectedMinutes = minutes[row]
    }
    
    // MARK: DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
}
