//
//  Items.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class Items: NSObject {
    
    static var shared = Items()
    
    var departments = [Department]()
    var components = [Component]()
    var decorations = [Decoration]()
    
    private override init() {
       self.departments.append(Department(storeName: "Computer", price: 0.5, image: #imageLiteral(resourceName: "computer"), description: "Need it to code", levelUnlocked: 0, tileName: "computer", departmentName: "Software"))
        self.departments.append(Department(storeName: "Server", price: 6, image: #imageLiteral(resourceName: "server"), description: "Bringin’ up the backend", levelUnlocked: 3, tileName: "server", departmentName: "Backend"))
        
        self.departments.append(Department(storeName: "Book", price: 2, image: #imageLiteral(resourceName: "book"), description: "Learn yourself some knowledge", levelUnlocked: 2, tileName: "book", departmentName: "Knowledge"))
        
        self.departments.append(Department(storeName: "Notebook", price: 2, image:  #imageLiteral(resourceName: "notepad"), description: "You never know where inspiration will strike", levelUnlocked: 0, tileName: "notepad", departmentName: "Ideas"))
        
        self.departments.append(Department(storeName: "Drawing Tablet", price: 4, image: #imageLiteral(resourceName: "tablet"), description: "Much better than using the mouse", levelUnlocked: 5, tileName: "drawing tablet", departmentName: "Graphics"))
        
        self.departments.append(Department(storeName: "TV", price: 8, image: #imageLiteral(resourceName: "TV"), description: "Show the world what to spend money on", levelUnlocked: 7, tileName: "TV", departmentName: "Advertising"))
        
        self.departments.append(Department(storeName: "Desk", price: 10, image:#imageLiteral(resourceName: "desk"), description: "Rule your company with a synergy-powered fist", levelUnlocked: 10, tileName: "desk", departmentName: "Management"))
        
        self.departments.append(Department(storeName: "Safe", price: 12, image: #imageLiteral(resourceName: "safe"), description: "Lock it all up", levelUnlocked: 15, tileName: "safe", departmentName: "Security"))
        
        self.departments.append(Department(storeName: "Phone", price: 15, image: #imageLiteral(resourceName: "phone"), description: "A respectable startup with respectable investors", levelUnlocked: 12, tileName: "phone", departmentName: "Investors"))
        
        
        //self.components.append(Component(storeName: "Name", price: 1.3, image: , description: "Description", levelUnlocked: 3, subtitle: "CoolSubtitle", timeInHours: 3, department: "Management"))
    }
}
