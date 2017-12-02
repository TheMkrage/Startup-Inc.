//
//  GameMap.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/1/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class GameMap: NSObject {
    var map = [[String]]()
    var rowCount: Int
    var colCount: Int
    
    init(row: Int, col: Int) {
        self.rowCount = row
        self.colCount = col
        self.map = Array(repeating: Array(repeating: "empty", count: col), count: row)
    }
    
    init(map: [[String]]) {
        self.map = map
        self.rowCount = self.map.count
        self.colCount = self.map[0].count
    }
    
    func set(tile: String, row: Int, col: Int) {
        map[row][col] = tile
        MapStore.shared.saveMap(map: self)
    }
    
    func getTile(row:Int, col: Int) -> String {
        return map[row][col]
    }
}
