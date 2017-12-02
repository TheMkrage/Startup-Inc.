//
//  SKTileGroup+Extensions.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
import SpriteKit

extension SKTileGroup {
    static func genereate(with image: UIImage) -> SKTileGroup {
        return SKTileGroup(tileDefinition: SKTileDefinition(texture: SKTexture(image: image), size: SKTexture(image: image).size()))
    }
}
