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
    var departmentMap = [String: Int]()
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
        super.init()
        for r in 0..<self.rowCount {
            for c in 0..<self.colCount {
                let tile = self.getTile(row: r, col: c)
                guard let departmentName = Items.shared.tileNameToDepartment[tile] else {
                    continue
                }
                self.addDepartment(with: departmentName)
            }
        }
    }
    
    // subtracts if a value is present
    private func subtractDepartment(with name: String) {
        if let currentVal = self.departmentMap[name] {
            self.departmentMap[name] = currentVal - 1
        }
    }
    
    // adds if value is present, if not sets value to one
    private func addDepartment(with name: String) {
        if let currentVal = self.departmentMap[name] {
            self.departmentMap[name] = currentVal + 1
        } else {
            self.departmentMap[name] = 1
        }
    }
    
    func set(tile: String, row: Int, col: Int) {
        let previousValue = map[row][col]
        if let prevDepartmentName = Items.shared.tileNameToDepartment[previousValue] {
            self.subtractDepartment(with: prevDepartmentName)
        }
        map[row][col] = tile
        if let departmentName = Items.shared.tileNameToDepartment[tile] {
            self.addDepartment(with: departmentName)
        }
        MapStore.shared.saveMap(map: self)
    }
    
    func getTile(row:Int, col: Int) -> String {
        return map[row][col]
    }
    
    func getNumberOfDepartment(with name: String) -> Int {
        guard let x = self.departmentMap[name] else {
            return 0
        }
        return x
    }
}
