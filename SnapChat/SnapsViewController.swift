//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    //MARK: - buttons and methods
    @IBAction func btnLogoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
