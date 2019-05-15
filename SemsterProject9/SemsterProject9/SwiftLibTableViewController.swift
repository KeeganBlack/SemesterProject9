//
//  SwiftLibTableViewController.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/6/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import UIKit
import os.log
import Firebase

class SwiftLibTableViewController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var swiftLibs: [SwiftLibObj] = []
    let rootRef = Database.database().reference()
    var users = [String]()
    typealias LibArrayClosure = (Array<SwiftLibObj>?) -> Void
    
    func loadSwiftLibs(){
        let lib1 = SwiftLibObj(title: "Long SwiftLib", author: "Donnie Darko", story: ["I wanted to make this a super long story to show that our project is really ", " and adjusts the text size based on the length of the story. My favorite thing to do is ", " because it is a great activity and makes me feel super great even when I have to wake up early!"], score: 0, args: ["awesome","program"])
        let lib2 = SwiftLibObj(title: "Romeo and Juliet", author: "Shakespeare", story: ["There were once two ", " lovers. Their names were Romeo and Juliet. One day they saw ", " which made them ", ". But that is just the beginning of the story..."], score: 5, args: ["crazy", "Paris", "cry"])
        let lib3 = SwiftLibObj(title: "My Typical Day", author: "Keegan Black", story: ["I usually wake up feeling ", " at around 10 am. Then I go ", " for about 30 minutes before starting my day. Next I have breakfast, usually some ", " bananas. Then I head to my day of classes!"], score: 10, args: ["refreshed","swim", "moldy"])
        let tempLibs = [lib1,lib2,lib3]
        for lib in tempLibs {
            saveToFirebase(lib: lib)
        }
       swiftLibs = tempLibs
    }
    
    func saveToFirebase(lib : SwiftLibObj) {
        let usersRef = rootRef.child("Users")
        let user = usersRef.child(lib.author).child("SwiftLibs")
        let values = ["Title":lib.title, "Score": lib.score, "Arguments": lib.arguments, "Story": lib.story] as [String : Any]
        user.childByAutoId().setValue(values)
    }
    
    func loadFromFireBase(completionHandler:@escaping (_ libArray: [SwiftLibObj]?)->()) {
        let childRef = rootRef.child("Users")
        var tempUsers = [String]()
        childRef.observe(.value, with: { (snapshot) in
            let userDict = snapshot.value as! [String: Any]
            var libs: [SwiftLibObj] = []
            for user in userDict.keys {
                tempUsers.append(user)
            }
            for user in tempUsers {
                let userSnaps = snapshot.childSnapshot(forPath: user).childSnapshot(forPath: "SwiftLibTemplates")
                for userSnap in userSnaps.children {
                    let snap = userSnap as! DataSnapshot
                    let values = snap.value as! [String: Any]
                    let lib = SwiftLibObj(title: values["Title"] as! String, author: user, story: values["Story"] as! [String], score: values["Score"] as! Int, args: values["Arguments"] as! [String])
                    libs.append(lib)
                }
            }
            if libs.isEmpty {
                completionHandler(nil)
            }else {
                completionHandler(libs)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CompleteSwiftlibSegue" ,
            let nextScene = segue.destination as? CompleteSwiftlibController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedLib = swiftLibs[indexPath.row]
            nextScene.lib = selectedLib
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //loadSwiftLibs()
        loadFromFireBase { libArray in
            let temp = libArray?.sorted(by: { (lib1: SwiftLibObj, lib2: SwiftLibObj) -> Bool in
                lib1.getScore() > lib2.getScore()
            })
            self.swiftLibs = temp ?? []
            self.tableView.reloadData()
        }
        tableView.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
