//
//  CompleteSwiftlibController.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/13/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CompleteSwiftlibController : UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var titleOutlet: UITextField!
    @IBOutlet weak var bodyOutlet: UILabel!
    
    let rootRef = Database.database().reference()
    var lib: SwiftLibObj? = nil
    var inputArgs: [String] = []
    var storyText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInputDialog()
        self.titleOutlet.text = self.lib?.getTitle()
        self.bodyOutlet.adjustsFontSizeToFitWidth = true
        self.titleOutlet.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        var username = usernameOutlet.text
        if username == "" || username == nil {
            username = "Anonymous"
        }
        let tempLib = SwiftLibObj(title: self.lib!.title, author: username ?? "Anonymous", story: self.lib!.story, score: 0, args: self.inputArgs)
        saveToFirebase(lib: tempLib)
        let viewController: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func saveToFirebase(lib : SwiftLibObj) {
        let usersRef = rootRef.child("Users")
        let user = usersRef.child(lib.author).child("SwiftLibs")
        let values = ["Title":lib.title, "Score": 0, "Arguments": lib.arguments, "Story": lib.story] as [String : Any]
        user.childByAutoId().setValue(values)
    }
    
    func mergeFunction<T>(_ one: [T], _ two: [T]) -> [T] {
        let commonLength = min(one.count, two.count)
        var merged = zip(one, two).flatMap { [$0, $1] }
        if one.count > commonLength { merged.append(one[commonLength]) }
        if two.count > commonLength { merged.append(two[commonLength]) }
        return merged
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Complete the blank fields.", message: "Please enter the part of speech for each blank.", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let num = alertController.textFields?.capacity
            for index in 0...num!-1 {
                self.inputArgs.append(alertController.textFields![index].text ?? "")
            }
            let storyElements = self.lib?.getStory() ?? []
            let story = self.mergeFunction(storyElements, self.inputArgs)
            for index in 0...story.count-1 {
                self.storyText.append(contentsOf: story[index])
            }
            self.bodyOutlet.text = self.storyText
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            let viewController: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
            self.present(viewController, animated: true, completion: nil)
        }
        
        //adding textfields to our dialog box
        for value in lib!.arguments {
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter a \(value)"
            }
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}
