//
//  MapStore.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct MapStore {
    static var shared = MapStore()
    
    private init() {
        
    }
    
    func getMap() -> GameMap {
        let userDefaults = UserDefaults.standard
        guard let map = userDefaults.array(forKey: "map") as? [[String]] else {
            return GameMap(row: 6, col: 6)
        }
        let toReturnMap = GameMap(row: map.count, col: map[0].count)
        let rows = toReturnMap.rowCount
        let cols = toReturnMap.colCount
        for r in 0..<rows {
            for c in 0..<cols {
                let tile = Tiles.getTiles(withName: map[r][c])
                toReturnMap.set(tile: tile, row: r, col: c)
            }
        }
        return toReturnMap
    }
    
    func saveMap(map: GameMap) {
        let rows = map.rowCount
        let cols = map.colCount
        var stringArray = Array(repeating: Array(repeating: "empty", count: cols), count: rows)
        let userDefaults = UserDefaults.standard
        
        for r in 0..<rows {
            for c in 0..<cols {
                let tile = map.getTile(row: r, col: c)
                stringArray[r][c] = tile.name
            }
        }
        userDefaults.set(stringArray, forKey: "map")
        userDefaults.synchronize()
    }
}
