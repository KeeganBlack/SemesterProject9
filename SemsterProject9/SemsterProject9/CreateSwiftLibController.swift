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
    
    
    @IBOutlet weak var TitleAction: UITextField!
    @IBOutlet weak var AuthorAction: UITextField!
    @IBOutlet var SwiftLibStory: UITextView!
    @IBOutlet weak var InsertButton: UIButton!
    @IBOutlet weak var ClearButtonOutlet: UIButton!
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    @IBOutlet var ActionButtons: [UIButton]!
    
    let rootRef = Database.database().reference()
    
    @IBAction func InsertBlank(_ sender: Any) {
        self.SwiftLibStory.text = self.SwiftLibStory.text + "{BLANK}"
    }
    
    @IBAction func SubmitSwiftLib(_ sender: Any) {
        if let author = AuthorAction.text {
            if let title = TitleAction.text {
                //Store obj in firebase using the author, title, story. Score would be 0 and args would be []
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
