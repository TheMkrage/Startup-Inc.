//
//  EmptyTile.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class EmptyTile: MapTile {
    
    var name = "rect"
    var isRequiringAllTileUpdate = false
    
    func tapped() {
        print("I got tapped!")
    }
}
