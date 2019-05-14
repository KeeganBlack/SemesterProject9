//
//  CreateSwiftLibController.swift
//  SemsterProject9
//
//  Created by Deepti Konduru on 5/11/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit


class CreateSwiftLibController : UIViewController {
    
    
    @IBOutlet weak var TitleAction: UITextField!
    
    @IBOutlet var SwiftLibStory: UITextView!
    
    @IBOutlet weak var InsertButton: UIButton!
    
    @IBOutlet weak var ClearButtonOutlet: UIButton!
    
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    
    @IBOutlet var ActionButtons: [UIButton]!
    
    @IBAction func InsertBlank(_ sender: Any) {
        self.SwiftLibStory.text = self.SwiftLibStory.text + "{BLANK}"
    }
    
    @IBAction func SubmitSwiftLib(_ sender: Any) {
        
    }
    
    @IBAction func ClearTextAction(_ sender: Any) {
    }
    
    

    @IBOutlet weak var Label: UILabel!
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }*/
    
}
