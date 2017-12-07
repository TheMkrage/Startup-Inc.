
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
    
    func save(departmentName: String, index: Int, hours: Int, minutes: Int, componentName: String) {
        let date = Date()
        let calendar = Calendar.current
        let userDefaults = UserDefaults.standard
        userDefaults.set(componentName, forKey: "\(departmentName)-\(index)-component")
        if hours == 0 {
             userDefaults.set(nil, forKey: "\(departmentName)-\(index)-time")
        } else {
            var finishDate = calendar.date(byAdding: .hour, value: hours, to: date)
            finishDate = calendar.date(byAdding: .minute, value: minutes, to: finishDate!)
            userDefaults.set(finishDate, forKey: "\(departmentName)-\(index)-time")
        }
    }
    
    func getRemainingTimeFor(departmentName: String, index: Int) -> (Int?, Int?) {
        let userDefaults = UserDefaults.standard
        guard let date = userDefaults.object(forKey: "\(departmentName)-\(index)-time") as? Date else {
            return (nil, nil)
        }
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hour = comp.hour
        let minute = comp.minute
        
        return (hour, minute)
    }
    
    func getComponentNameFor(departmentName: String, index: Int) -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "\(departmentName)-\(index)-component")
    }
    
}
