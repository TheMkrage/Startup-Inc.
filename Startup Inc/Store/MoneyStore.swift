//
//  MoneyStore.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct MoneyStore {
    static var shared = MoneyStore()
    
    var startingMoney = 1.0
    var money: Double
    
    private init() {
        let userDefaults = UserDefaults.standard
        var savedMoney = userDefaults.double(forKey: "money")
        if savedMoney == 0 {
            savedMoney = startingMoney
        }
        self.money = savedMoney
        userDefaults.synchronize()
    }
    
    mutating func purchase(price: Double) -> Bool {
        if self.money < price {
            return false
        }
        self.money = self.money - price
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.money, forKey: "money")
        userDefaults.synchronize()
        return true
    }
    
    mutating func earn(price: Double) {
        self.money = self.money + price
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.money, forKey: "money")
        userDefaults.synchronize()
    }
    
    
}
