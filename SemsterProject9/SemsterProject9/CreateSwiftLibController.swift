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
    @IBOutlet weak var InsertButton: UIButton!
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
    
    
    
    @IBAction func SubmitSwiftLib(_ sender: Any) {
        let author = AuthorAction.text
        let title = TitleAction.text
        saveToFirebase(lib: SwiftLibObj(title: title ?? "None", author: author ?? "Anonymous", story: <#T##[String]#>, score: <#T##Int#>, args: <#T##[String]#>))
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
