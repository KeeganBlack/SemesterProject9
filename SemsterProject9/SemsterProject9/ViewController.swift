//
//  ViewController.swift
//  SemsterProject9
//
//  Created by Logan Harris on 4/21/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AppTitleLabel: UILabel!
    

    
    @IBOutlet var ButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        AppTitleLabel.textColor = UIColor.blue
        for button in ButtonCollection {
            button.backgroundColor = UIColor.blue
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            UIView.animate(withDuration: 1, animations: {
                button.frame.size.width += 10
                button.frame.size.height += 10
            }) {
                _ in
                UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations:{ button.frame.origin.y -= 20})
                
            }
        }
        
       
    }

}

extension UIColor{
    
}

