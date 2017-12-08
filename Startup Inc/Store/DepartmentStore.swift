
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
    
    func save(departmentName: String, time: (hours: Int, minutes: Int, seconds: Int)?, capacity: Int, componentName: String) {
        let date = Date()
        let calendar = Calendar.current
        let userDefaults = UserDefaults.standard
        
        for i in 0..<capacity {
            if userDefaults.string(forKey: "\(departmentName)-\(i)-component") == nil {
                guard let time = time else {
                    userDefaults.set(nil, forKey: "\(departmentName)-\(i)-time")
                    userDefaults.synchronize()
                    return
                }
                var finishDate = calendar.date(byAdding: .hour, value: time.hours, to: date)
                finishDate = calendar.date(byAdding: .minute, value: time.minutes, to: finishDate!)
                finishDate = calendar.date(byAdding: .second, value: time.seconds, to: finishDate!)
                userDefaults.set(componentName, forKey: "\(departmentName)-\(i)-component")
                userDefaults.set(finishDate, forKey: "\(departmentName)-\(i)-time")
                
                userDefaults.synchronize()
                return
            }
        }
    }
    
    func getRemainingTimeFor(departmentName: String, index: Int) -> (hours: Int, minutes: Int, seconds: Int)? {
        let userDefaults = UserDefaults.standard
        guard let date = userDefaults.object(forKey: "\(departmentName)-\(index)-time") as? Date else {
            return nil
        }
        let now = Date()
        print(now)
        print(date)
        // if the thing is not ready to harvest
        if date > now {
            let calendar = Calendar.current
            
            let comp = calendar.dateComponents([.hour, .minute, .second], from: now, to: date)
            let hour = comp.hour ?? 0
            let minute = comp.minute ?? 0
            let seconds = comp.second ?? 0
            
            return (hours: hour, minutes: minute, seconds: seconds)
        } else {
            return (0, 0, 0)
        }
        
    }
    
    func getComponentNameFor(departmentName: String, index: Int) -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "\(departmentName)-\(index)-component")
    }
    
    func harvest(departmentName: String, index: Int) {
        guard let componentName = getComponentNameFor(departmentName: departmentName, index: index) else {
            fatalError()
        }
        // add item to inventory
        InventoryStore.shared.add(componentName: componentName)
        
        // remove item from memory
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "\(departmentName)-\(index)-component")
        userDefaults.set(nil, forKey: "\(departmentName)-\(index)-time")
        userDefaults.synchronize()
    }
}
