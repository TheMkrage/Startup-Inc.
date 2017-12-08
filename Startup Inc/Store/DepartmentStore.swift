
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
    
    func save(departmentName: String, index: Int, time: (hours: Int, minutes: Int, seconds: Int)?, componentName: String) {
        let date = Date()
        let calendar = Calendar.current
        let userDefaults = UserDefaults.standard
        
        guard let time = time else {
            userDefaults.set(nil, forKey: "\(departmentName)-\(index)-time")
            userDefaults.synchronize()
            return
        }
        var finishDate = calendar.date(byAdding: .hour, value: time.hours, to: date)
        finishDate = calendar.date(byAdding: .minute, value: time.minutes, to: finishDate!)
        finishDate = calendar.date(byAdding: .second, value: time.seconds, to: finishDate!)
        userDefaults.set(componentName, forKey: "\(departmentName)-\(index)-component")
        userDefaults.set(finishDate, forKey: "\(departmentName)-\(index)-time")
    
        userDefaults.synchronize()
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
    
    func harvest(departmentName: String, index:Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "\(departmentName)-\(index)-component")
        userDefaults.set(nil, forKey: "\(departmentName)-\(index)-time")
        userDefaults.synchronize()
    }
    
}
