//
//  InventoryStore.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/8/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct InventoryStore {
    
    static var shared = InventoryStore()
    
    private init() {    }

    func add(componentName: String) {
        let userDefaults = UserDefaults.standard
        guard let currentInventory = userDefaults.object(forKey: "\(componentName)-inventory") as? Int else {
            userDefaults.set(1, forKey: "\(componentName)-inventory")
            return
        }
        userDefaults.set(currentInventory + 1, forKey: "\(componentName)-inventory")
    }
    
    func substract(componentName: String) {
        let userDefaults = UserDefaults.standard
        guard let currentInventory = userDefaults.object(forKey: "\(componentName)-inventory") as? Int else {
            userDefaults.set(0, forKey: "\(componentName)-inventory")
            return
        }
        userDefaults.set(currentInventory - 1, forKey: "\(componentName)-inventory")
    }
    
    func get(componentName: String) -> Int {
        let userDefaults = UserDefaults.standard
        guard let currentInventory = userDefaults.object(forKey: "\(componentName)-inventory") as? Int else {
            return 0
        }
        return currentInventory
    }
}
