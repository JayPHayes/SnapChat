//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    var imageURL: String = ""
    var desc: String = ""
    var uuid: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snaphot) in
            print(snaphot)
            let usr = User()
            
            usr.email = snaphot.childSnapshot(forPath: "email").value as! String
            usr.uid = snaphot.key
            
            self.users.append(usr)
            self.tableView.reloadData()
            
        })
    }

    
    //MARK: - tableView Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let usr = users[indexPath.row]
        let snap = [
            "from": FIRAuth.auth()!.currentUser!.email,
            "description": self.desc,
            "imageURL": self.imageURL,
            "uuid": uuid
            ]
        FIRDatabase.database().reference().child("users").child(usr.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController!.popToRootViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let user = users[indexPath.row]
        
        cell?.textLabel?.text = user.email
        
        return cell!;
    }
    //MARK: - button and methods


}
