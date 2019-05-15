//
//  ViewController.swift
//  SemsterProject9
//
//  Created by Logan Harris on 4/21/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var CreateSwiftButton: UIButton!
    
    @IBOutlet weak var SearchSwiftButton: UIButton!
    
    @IBOutlet weak var BrowseSwiftButton: UIButton!
    @IBOutlet var ButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        CreateSwiftButton.backgroundColor = UIColor.ThemeColors.BlueGreen
        SearchSwiftButton.backgroundColor = UIColor.ThemeColors.OceanBlue
        BrowseSwiftButton.backgroundColor = UIColor.ThemeColors.PalerBlue
        
        var duration = 0.7
        for button in ButtonCollection {

            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
            
            
          /* UIView.animate(withDuration: duration, animations: {
                button.frame.size.width += 20
                button.frame.size.height += 20
            }) {
                _ in
                UIView.animate(withDuration: duration, delay: 0.10, options: [.curveEaseOut], animations:{ button.frame.origin.y -= 40})
                
            } */
            duration += 0.3
        }
        
       

}
}

extension UIColor{
    struct ThemeColors {
        static let OceanBlue = UIColor(red: 177/255, green: 240/255, blue: 242/255, alpha: 1)
        static let PalerBlue = UIColor(red: 179/255, green: 223/255, blue: 243/255, alpha: 1)
        static let BlueGreen = UIColor(red: 185/255, green: 241/255, blue: 206/255, alpha: 1)
        
    }
}

