//
//  SwiftLibObj.swift
//  SemsterProject9
//
//  Created by Logan Harris on 4/21/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation

class SwiftLibObj {
    
    let title: String
    let author: String
    let score: Int
    let arguments : [String] = ["Noun","Noun","Noun"];
    let story : [String] = ["I took my","a walk and saw a"];
    
    init(title: String, author: String, score: Int) {
        self.title = title;
        self.author = author;
        self.score = score;
    }
    
}
