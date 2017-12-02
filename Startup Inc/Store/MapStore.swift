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
    
    private init() {    }
    
    func getMap() -> GameMap {
        let userDefaults = UserDefaults.standard
        guard let map = userDefaults.array(forKey: "map") as? [[String]] else {
            return GameMap(row: 6, col: 6)
        }
        return GameMap(map: map)
    }
    
    func saveMap(map: GameMap) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(map.map, forKey: "map")
        userDefaults.synchronize()
    }
}
