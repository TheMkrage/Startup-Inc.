
//
//  DepartmentStore.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct DepartmentStore {
    
    static var shared = DepartmentStore()
    
    private init() {    }
    
    func save(name: String, index: Int, finishTime: Date?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(finishTime, forKey: "\(name)-\(index)")
    }
    
    func getFinishTimeFor(name: String, index: Int) -> Date? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "\(name)-\(index)") as? Date
    }
}
