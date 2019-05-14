//
//  CompleteSwiftlibController.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/13/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit

class CompleteSwiftlibController : UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var bodyOutlet: UITextField!
    @IBOutlet weak var titleOutlet: UITextField!
    
    var lib: SwiftLibObj? = nil
    var inputArgs: [String] = []
    var storyText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInputDialog()
    }
    
    func mergeFunction<T>(one: [T], _ two: [T]) -> [T] {
        let maxIndex = max(one.count, two.count)
        var mergedArray = Array<T>()
        for index in 0..<maxIndex {
            if index < one.count { mergedArray.append(one[index]) }
            if index < two.count { mergedArray.append(two[index]) }
        }
        return mergedArray
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
            let story = self.mergeFunction(one: storyElements, self.inputArgs)
            for index in 0...storyElements.count-1 {
                self.storyText.append(contentsOf: story[index])
            }
            print(self.storyText)
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
