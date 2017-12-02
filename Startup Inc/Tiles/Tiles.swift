//
//  Tiles.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct Tiles {
    
    static var dictionary: [String : MapTile] = ["empty": EmptyTile(), "button": ButtonTile()]
    
    static func getTiles(withName: String) -> MapTile {
        return dictionary[withName] ?? EmptyTile()
    }
}
