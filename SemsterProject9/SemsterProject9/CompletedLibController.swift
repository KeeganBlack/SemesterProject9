//
//  CompletedLibController.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/14/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CompletedLibController : UIViewController {

    @IBOutlet weak var storyOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var scoreOutlet: UILabel!
    @IBOutlet weak var voteController: UISegmentedControl!
    @IBOutlet weak var authorOutlet: UILabel!
    
    var lib: SwiftLibObj? = nil
    var storyText = ""
    let rootRef = Database.database().reference()
    var selectedFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleOutlet.text = self.lib?.getTitle()
        let story = mergeFunction(self.lib!.story, self.lib!.arguments)
        for index in 0...story.count-1 {
            self.storyText.append(contentsOf: story[index])
        }
        self.storyOutlet.text = self.storyText
        self.storyOutlet.adjustsFontSizeToFitWidth = true
        self.titleOutlet.adjustsFontSizeToFitWidth = true
        self.scoreOutlet.text = String(self.lib!.getScore())
        self.authorOutlet.text = "By: \(String(describing: self.lib!.author))"
    }
    
    @IBAction func votePressed(_ sender: Any) {
        switch voteController.selectedSegmentIndex
        {
        case 0:
            //adjustScore(direction: false)
            self.scoreOutlet.text = String(self.lib!.getScore()-1)
        case 1:
            //adjustScore(direction: true)
            self.scoreOutlet.text = String(self.lib!.getScore()+1)
        default:
            break
        }
    }
    
    func adjustScore(direction: Bool) {
        if(direction == true) {
            let temp = SwiftLibObj(title: self.lib?.title ?? "", author: self.lib?.author ?? "", story: self.lib?.story ?? [], score: self.lib!.score+1, args: self.lib?.arguments ?? [])
            saveToFirebase(lib: temp)
        } else {
            let temp = SwiftLibObj(title: self.lib?.title ?? "", author: self.lib?.author ?? "", story: self.lib?.story ?? [], score: self.lib!.score-1, args: self.lib?.arguments ?? [])
            saveToFirebase(lib: temp)

        }
    }
    
    func saveToFirebase(lib : SwiftLibObj) {
        let usersRef = rootRef.child("Users")
        let user = usersRef.child(lib.author).child("SwiftLibs")
        let values = ["Title":lib.title, "Score": lib.score, "Arguments": lib.arguments, "Story": lib.story] as [String : Any]
        user.childByAutoId().setValue(values)
    }
    
    func mergeFunction<T>(_ one: [T], _ two: [T]) -> [T] {
        let commonLength = min(one.count, two.count)
        var merged = zip(one, two).flatMap { [$0, $1] }
        if one.count > commonLength { merged.append(one[commonLength]) }
        if two.count > commonLength { merged.append(two[commonLength]) }
        return merged
    }
    
}
