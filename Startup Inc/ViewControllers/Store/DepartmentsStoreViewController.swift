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
    
    override func didBuyItem(sender: UIButton) {
        super.didBuyItem(sender: sender)
        guard let department = self.items[sender.tag] as? Department else {
            fatalError()
        }
        let userInfo = ["tileName": department.tileName]
        NotificationCenter.default.post(name: .init("boughtPlacementItem"), object: nil, userInfo: userInfo)
    }

}
