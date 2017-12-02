//
//  MapTile.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
protocol MapTile {
    var name: String {get}
    var isRequiringAllTileUpdate: Bool {get set}
    func tapped()
}

