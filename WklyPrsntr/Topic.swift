//
//  Topic.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 09.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import Foundation

struct Topic: Codable {
    let presenter: String
    let topic: String
    let minutes: Double
}

extension Topic {
    
    var secondos: Double {
        return minutes * 60.0
    }
    
    static let topics = [
        Topic(presenter: "Malte", topic: "Bodyleasing", minutes: 10.0),
        Topic(presenter: "Daniel", topic: "CREAM", minutes: 5.0),
        Topic(presenter: "Stefan", topic: "Ein geheimes Thema 🔮 mit einem sehr langem Titel.", minutes: 0.1)
    ]
}
