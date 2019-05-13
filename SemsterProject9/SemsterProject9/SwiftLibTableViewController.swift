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
        let lib1 = SwiftLibObj(title: "My Awesome SwiftLib", author: "Keegan Black", story: ["One day I had a", "and it was great for my"])
        let lib2 = SwiftLibObj(title: "How to code in Swift", author: "Deepti Konduru", story: ["Coding is swift is", "mostly because the", "is too", "or just plain confusing!"])
        let lib3 = SwiftLibObj(title: "How to pass CSMC 434", author: "Logan Harris", story: ["I'm taking 434 next semester so I hope it's easy. The end."])
        let tempLibs = [lib1,lib2,lib3]
        for lib in tempLibs {
            saveToFirebase(lib: lib)
        }
       swiftLibs = tempLibs
    }
    
    func saveToFirebase(lib : SwiftLibObj) {
        let usersRef = rootRef.child("Users")
        let user = usersRef.child(lib.author)
        let values = ["Title":lib.title, "Score": lib.score, "Arguments": lib.arguments, "Story": lib.story] as [String : Any]
        user.setValue(values)
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
                let userSnap = snapshot.childSnapshot(forPath: user)
                let values = userSnap.value as! [String: Any]
                let lib = SwiftLibObj(title: values["Title"] as! String, author: user, story: values["Story"] as! [String], score: values["Score"] as! Int)
                libs.append(lib)
            }
            if libs.isEmpty {
                completionHandler(nil)
            }else {
                completionHandler(libs)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadFromFireBase { libArray in
            self.swiftLibs = libArray ?? []
            self.tableView.reloadData()
        }
        tableView.dataSource = self
    }

    // MARK: - Table view data source

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
