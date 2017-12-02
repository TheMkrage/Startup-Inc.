//
//  BuyableItem.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

protocol BuyableItem {
    var storeName: String {get set}
    var price: Double {get set}
    var image: UIImage {get set}
    var description: String {get set}
    var levelUnlocked: Int {get set}
    var subtitle: String {get set}
}
