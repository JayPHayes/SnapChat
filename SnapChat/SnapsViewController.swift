//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//   Test Source

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var snaps: [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        
        let currUser = FIRAuth.auth()?.currentUser
        FIRDatabase.database().reference().child("users").child(currUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let snap = Snap()
            snap.imageURL =  snapshot.childSnapshot(forPath: "imageURL").value as! String
            snap.desc =  snapshot.childSnapshot(forPath: "description").value as! String
            snap.from =  snapshot.childSnapshot(forPath: "from").value as! String
            snap.uuid =  snapshot.childSnapshot(forPath: "uuid").value as! String
            snap.key  = snapshot.key
            
            self.snaps.append(snap)
            self.tableView.reloadData()
            print("Snap Count: \(self.snaps.count)")
        })

        FIRDatabase.database().reference().child("users").child(currUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                
                index += 1
            }
        
            self.tableView.reloadData()
        })

        
        print("Snap Count: \(snaps.count) - Self Snap Count: \(self.snaps.count)")
        


    }

    //MARK: - Tableview methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap =  snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if snaps.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "You have no snaps 😒"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            let snp = self.snaps[indexPath.row]
            cell?.textLabel?.text = "FROM: \(snp.from)"
            
            return cell!
        }
        
        
        
        
    }
    
   
    //MARK: - buttons and methods
    @IBAction func btnLogoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
