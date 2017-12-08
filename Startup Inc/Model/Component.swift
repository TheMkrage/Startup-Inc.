//
//  Component.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct Component: BuyableItem {
    
    var storeName: String
    var price: Double
    var image: UIImage
    var description: String
    var levelUnlocked: Int
    var subtitle: String {
        get {
            return "\(self.time.hours) hr \(self.time.minutes) m"
        }
        set {   }
    }
    var time: (hours: Int, minutes: Int, seconds: Int)
    var department: String
}
