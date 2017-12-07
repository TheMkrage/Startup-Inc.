//
//  ComponentStoreViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
class ActiveComponent {
    var hours: Int?
    var minutes: Int?
    var image: UIImage
    var name: String
    
    init(hours: Int?, minutes: Int?, image: UIImage, name: String) {
        self.hours = hours
        self.minutes = minutes
        self.image = image
        self.name = name
    }
}

// solely the components that are ready for harvest or in process
class ActiveComponentTableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var activeComponents = [ActiveComponent]()
    var indices = 0
    var departmentName = ""
    
    init(departmentName: String, indices: Int) {
        self.indices = indices
        self.departmentName = departmentName
        super.init()
        //self.reloadComponents()
    }
    
    func reloadComponents() {
        var openDeps = 0
        var newComponents = [ActiveComponent]()
        for i in 0..<self.indices {
            guard let minutes = DepartmentStore.shared.getRemainingTimeFor(departmentName: departmentName, index: i).0, let hours = DepartmentStore.shared.getRemainingTimeFor(departmentName: departmentName, index: i).1, let name = DepartmentStore.shared.getComponentNameFor(departmentName: departmentName, index: i), let image = Items.shared.getComponentImage(with: name) else {
                openDeps = openDeps + 1
                continue
            }
            newComponents.append(ActiveComponent(hours: hours, minutes: minutes, image: image, name: name))
        }
        self.activeComponents = newComponents
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reloadComponents()
        return activeComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.activeComponents[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveComponent") as? ActiveComponentTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = item.name
        cell.iconView.image = item.image
        cell.hoursLabel.text = "\(item.hours ?? 0) hr \(item.minutes ?? 0) m"
        cell.isUserInteractionEnabled = true
        return cell
    }
}

class ComponentStoreViewController: StoreViewController {

    @IBOutlet weak var topTable: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var departmentName: String?
    var topController: ActiveComponentTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topController = ActiveComponentTableController(departmentName: self.departmentName ?? "", indices: MapStore.shared.getMap().getNumberOfDepartment(with: self.departmentName ?? ""))
        
        self.title = self.departmentName
        
        self.items = Items.shared.components.filter({ (c) -> Bool in
            return c.department == self.departmentName
        })
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.topTable.delegate = self.topController
        self.topTable.dataSource = self.topController
    }
    
    override func didBuyItem(sender: UIButton) {
        guard let item = self.items[sender.tag] as? Component else {
            fatalError()
        }
        let indicesAvailable = MapStore.shared.getMap().getNumberOfDepartment(with: self.departmentName ?? "")
        guard let currentNumberOfDepartmentsBeingUsed = self.topController?.activeComponents.count else {
            fatalError()
        }
        let difference = indicesAvailable - currentNumberOfDepartmentsBeingUsed
        if difference > 0 {
            DepartmentStore.shared.save(departmentName: self.departmentName ?? "", index: difference - 1, hours: item.hours, minutes: item.minutes, componentName: item.storeName)
            self.topTable.reloadData()
        }
    }
}
