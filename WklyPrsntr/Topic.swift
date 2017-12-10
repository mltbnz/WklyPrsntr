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
    let title: String
    let minutes: Double
}

extension Topic {
    
    var secondos: Double {
        return minutes * 60.0
    }
}
