//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imgSnap: UIImageView!
    @IBOutlet weak var lblSnap: UILabel!
    
    var snap = Snap()
    let currUsr = FIRAuth.auth()!.currentUser
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblSnap.text = snap.desc
        imgSnap.sd_setImage(with: URL(string: snap.imageURL) )
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("GoodBy")
        
        FIRDatabase.database().reference().child("users").child(currUsr!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child(snap.uuid).delete { (error) in
            print("We deleted the pic")
        }
    }


}
