//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.reloadData()
    }

    
    //MARK: - tableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Have a nice day."
        
        return cell!;
    }
    //MARK: - button and methods


}
