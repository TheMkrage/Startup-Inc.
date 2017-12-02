//
//  DepartmentsStoreViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class DepartmentsStoreViewController: StoreViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = Items.shared.departments
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}
