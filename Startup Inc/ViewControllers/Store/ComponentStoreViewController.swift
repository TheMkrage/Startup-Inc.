//
//  ComponentStoreViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
class ActiveComponent {
    var time: (Int, Int, Int) // hours minute seconds
    var image: UIImage
    var name: String
    var index: Int
    
    init(time: (Int, Int, Int), image: UIImage, name: String, index: Int) {
        self.time = time
        self.image = image
        self.name = name
        self.index = index
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
            guard let time = DepartmentStore.shared.getRemainingTimeFor(departmentName: departmentName, index: i), let name = DepartmentStore.shared.getComponentNameFor(departmentName: departmentName, index: i), let image = Items.shared.getComponentImage(with: name) else {
                openDeps = openDeps + 1
                continue
            }
            
            newComponents.append(ActiveComponent(time: time, image: image, name: name, index: i))
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
        if item.time.0 == 0 && item.time.1 == 0 && item.time.2 == 0 {
            cell.hoursLabel.text = "DONE"
        } else {
            cell.hoursLabel.text = "\(item.time.0 ?? 0) hr \(item.time.1 ?? 0) m \(item.time.2 ?? 0) m"
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.activeComponents[indexPath.row]
        if item.time.0 == 0 && item.time.1 == 0 && item.time.2 == 0 {
            DepartmentStore.shared.harvest(departmentName: self.departmentName, index: item.index)
            tableView.reloadData()
        }
    }
}

class ComponentStoreViewController: StoreViewController {

    @IBOutlet weak var topTable: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var departmentName: String?
    var topController: ActiveComponentTableController?
    
    var myTimer = Timer()
    
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
        
        self.myTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        RunLoop.main.add(self.myTimer, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc func refresh() {
        self.topTable.reloadData()
    }
    
    
    override func didBuyItem(sender: UIButton) {
        guard let item = self.items[sender.tag] as? Component else {
            fatalError()
        }
        let indicesAvailable = MapStore.shared.getMap().getNumberOfDepartment(with: self.departmentName ?? "")
        guard let currentNumberOfDepartmentsBeingUsed = self.topController?.activeComponents.count else {
            fatalError()
        }
        let difference = currentNumberOfDepartmentsBeingUsed
        if difference < indicesAvailable {
            DepartmentStore.shared.save(departmentName: departmentName ?? "", index: difference, time: item.time, componentName: item.storeName)
            self.topTable.reloadData()
        }
    }
}
