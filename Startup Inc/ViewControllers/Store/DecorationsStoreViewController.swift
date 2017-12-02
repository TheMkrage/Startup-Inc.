//
//  DecorationsStoreViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class DecorationsStoreViewController: StoreViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = Items.shared.decorations
        // Do any additional setup after loading the view.
    }
}
