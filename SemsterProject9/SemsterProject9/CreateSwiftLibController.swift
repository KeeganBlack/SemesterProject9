//
//  CreateSwiftLibController.swift
//  SemsterProject9
//
//  Created by Deepti Konduru on 5/11/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateSwiftLibController : UIViewController {
    
    var args : [String] = []
    
    @IBOutlet weak var TitleAction: UITextField!
    @IBOutlet weak var AuthorAction: UITextField!
    @IBOutlet var SwiftLibStory: UITextView!
    @IBOutlet weak var ClearButtonOutlet: UIButton!
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    @IBOutlet var ActionButtons: [UIButton]!
    
    @IBAction func AdjAction(_ sender: UIButton) {
        self.SwiftLibStory.text = self.SwiftLibStory.text + " {Adjective} "
        args.append("Adjective")
    }
    
    @IBAction func NounAction(_ sender: UIButton) {
        self.SwiftLibStory.text = self.SwiftLibStory.text + " {Noun} "
        args.append("Noun")
    }
    
    @IBAction func VerbAction(_ sender: UIButton) {
        self.SwiftLibStory.text = self.SwiftLibStory.text + " {Verb} "
        args.append("Verb")
    }
    
    let rootRef = Database.database().reference()
    
    func splitStory(story: String) -> [String] {
        return story.components(separatedBy: " ")
    }
    
    @IBAction func SubmitSwiftLib(_ sender: Any) {
        if let author = AuthorAction.text {
            if let title = TitleAction.text {
                let temp = SwiftLibObj(title: title, author: author, story: splitStory(story: SwiftLibStory.text), score: 0, args: args)
                saveToFirebase(lib: temp)
                let viewController: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func ClearTextAction(_ sender: Any) {
        self.SwiftLibStory.text = ""
    }
    
    func saveToFirebase(lib : SwiftLibObj) {
        let usersRef = rootRef.child("Users")
        let user = usersRef.child(lib.author).child("SwiftLibTemplates")
        let values = ["Title":lib.title, "Score": 0, "Arguments": lib.arguments, "Story": lib.story] as [String : Any]
        user.childByAutoId().setValue(values)
    }
    
}
