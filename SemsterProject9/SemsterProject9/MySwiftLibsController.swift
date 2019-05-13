//
//  MySwiftLibsController.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/13/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MySwiftLibTableViewController: UITableViewController {
    
    let rootRef = Database.database().reference()
    var user: String = ""
    var swiftLibs: [SwiftLibObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInputDialog()
        print(self.user)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return swiftLibs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SwiftLibTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SwiftLibTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let lib = swiftLibs[indexPath.row]
        cell.authorOutlet.text = "By \(lib.author)"
        cell.scoreOutlet.text = String(lib.score)
        cell.titleOutlet.text = String(lib.title)
        return cell
    }
    
    func loadFromFireBase(completionHandler:@escaping (_ libArray: [SwiftLibObj]?)->()) {
        if(self.user != "") {
            let userRef = rootRef.child("Users").child(self.user)
            userRef.observe(.value, with: { (snapshot) in
                let values = snapshot.value as! [String: Any]
                var libs: [SwiftLibObj] = []
                let lib = SwiftLibObj(title: values["Title"] as! String, author: self.user, story: values["Story"] as! [String], score: values["Score"] as! Int)
                libs.append(lib)
                if libs.isEmpty {
                    completionHandler(nil)
                }else {
                    completionHandler(libs)
                }
            })
        }
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "What is your Username?", message: "Please enter the Username you would like to view.", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            self.user = alertController.textFields?[0].text ?? ""
            self.loadFromFireBase{ libArray in
                self.swiftLibs = libArray ?? []
                self.tableView.reloadData()
            }
            //self.labelMessage.text = "Name: " + name! + "Email: " + email!
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Username"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}
