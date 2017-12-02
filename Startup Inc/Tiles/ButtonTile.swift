//
//  ButtonTile.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class ButtonTile: MapTile {
    
    var name = "Button"
    var isRequiringAllTileUpdate = false
    
    func tapped() {
        if self.name == "Button" {
            self.name = "Button-Pressed"
        } else {
            self.name = "Button"
        }
    }
}
