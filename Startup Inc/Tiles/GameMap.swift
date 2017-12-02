//
//  GameMap.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class GameMap: NSObject {
    var map = [[MapTile]]()
    var rowCount: Int
    var colCount: Int
    
    init(row: Int, col: Int) {
        self.rowCount = row
        self.colCount = col
        self.map = Array(repeating: Array(repeating: EmptyTile(), count: col), count: row)
    }
    
    func set(tile: MapTile, row: Int, col: Int) {
        map[row][col] = tile
    }
    
    func getTile(row:Int, col: Int) -> MapTile {
        return map[row][col]
    }
    
    func tapped(row:Int, col: Int) {
        if row < rowCount && col < colCount {
            map[row][col].tapped()
        }
    }
}
