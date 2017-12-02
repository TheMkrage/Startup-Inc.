//
//  Department.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct Department: BuyableItem {
    var storeName: String
    var price: Double
    var image: UIImage
    var description: String
    var levelUnlocked: Int
    
    var subtitle: String {
        get {
            return self.departmentName
        }
        set {
            self.departmentName = newValue
        }
    }
    
    var departmentName: String
    
    
}
