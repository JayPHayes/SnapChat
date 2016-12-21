//
//  SignInViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/19/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Button and Methods
    @IBAction func btnTurnUp(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
            
            print("We tried to sign in")
            if error != nil {
                print("Hey, we have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("We have an error: \(error)")
                    } else {
                        print("Created user succesfully!")
                        self.performSegue(withIdentifier: "signinSegue", sender: nil)
                    }
                    
                })
                
            } else {
                print("Signed in Successfully!")
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        })
        
    }
    
}
