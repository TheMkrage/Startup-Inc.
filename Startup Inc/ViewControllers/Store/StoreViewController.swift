//
//  StoreViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [BuyableItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Store") as? StoreTableViewCell else {
            return UITableViewCell()
        }
        cell.buyButton.setTitle("\(item.price)k", for: .normal)
        cell.buyButton.addTarget(self, action: #selector(didBuyItem(sender:)), for: .touchUpInside)
        cell.buyButton.tag = indexPath.row
        cell.nameLabel.text = item.storeName
        cell.subtitleLabel.text = item.subtitle
        cell.descriptionLabel.text = item.description
        cell.iconView.image = item.image
        cell.isUserInteractionEnabled = true
        return cell
        
    }
    
    @objc func didBuyItem(sender: UIButton) {
        print(sender.tag)
    }
}
