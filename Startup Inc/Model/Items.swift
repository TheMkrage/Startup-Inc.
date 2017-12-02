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
       self.departments.append(Department(storeName: "Computer", price: 3, image: #imageLiteral(resourceName: "computer"), description: "Hack away the sorrows", levelUnlocked: 1, departmentName: "Software"))
    }
}
