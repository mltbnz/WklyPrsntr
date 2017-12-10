//
//  StartViewController.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 10.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var topics: [Topic] = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if topics.isEmpty && identifier == "startWeekySegue" {
            return false
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTopicSegue" {
            let dest = segue.destination as! AddTopicViewController
            dest.delegate = self
        } else if segue.identifier == "startWeekySegue" {
            let dest = segue.destination as! PresentationViewController
            dest.topics = topics
        }
    }
}

extension StartViewController: TopicAddable {
    func didCreateTopic(_ topic: Topic) {
        topics.append(topic)
        tableView.reloadData()
    }
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TopicPreviewTableViewCell else {
            fatalError("Did not find cell")
        }
        let topic = topics[indexPath.row]
        cell.presenterLable.text = topic.presenter
        cell.topicLabel.text = topic.title
        cell.timeLabel.text = CountDown.timeFormatted(topic.secondos)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = topics[sourceIndexPath.row]
        topics.remove(at: sourceIndexPath.row)
        topics.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}
