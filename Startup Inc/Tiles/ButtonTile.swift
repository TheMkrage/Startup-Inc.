//
//  ButtonTile.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class ButtonTile: MapTile {
    
    var name = "button"
    var isRequiringAllTileUpdate = false
    
    func tapped() {
        if self.name == "button" {
            self.name = "button-pressed"
        } else {
            self.name = "button"
        }
    }
}
