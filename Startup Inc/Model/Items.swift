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
       self.departments.append(Department(storeName: "Test", price: 3, image: #imageLiteral(resourceName: "rect"), description: "Fucker", levelUnlocked: 1, departmentName: "Bleh"))
    }
}
