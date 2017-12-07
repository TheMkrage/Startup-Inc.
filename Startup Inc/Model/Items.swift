//
//  Items.swift
//  Startup Inc
//
//  Created by Matthew Krager on 12/2/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class Items: NSObject {
    
    static var shared = Items()
    
    var departments = [Department]()
    var components = [Component]()
    var decorations = [Decoration]()
    
    var tileNameToDepartment: [String: String] = ["server": "Backend", "computer": "Software", "book": "Knowledge", "notepad": "Ideas", "tablet": "Graphics", "desk": "Management", "safe": "Security"]
    
    func getComponentImage(with name: String) -> UIImage? {
        return self.components.first(where: { (c) -> Bool in
            return c.storeName == name
        })?.image
    }
    
    private override init() {
       self.departments.append(Department(storeName: "Computer", price: 0.5, image: #imageLiteral(resourceName: "computer"), description: "Need it to code", levelUnlocked: 0, tileName: "computer", departmentName: "Software"))
        self.departments.append(Department(storeName: "Server", price: 6, image: #imageLiteral(resourceName: "server"), description: "Bringin’ up the backend", levelUnlocked: 3, tileName: "server", departmentName: "Backend"))
        
        self.departments.append(Department(storeName: "Book", price: 2, image: #imageLiteral(resourceName: "book"), description: "Learn yourself some knowledge", levelUnlocked: 2, tileName: "book", departmentName: "Knowledge"))
        
        self.departments.append(Department(storeName: "Notebook", price: 2, image:  #imageLiteral(resourceName: "notepad"), description: "You never know where inspiration will strike", levelUnlocked: 0, tileName: "notepad", departmentName: "Ideas"))
        self.departments.append(Department(storeName: "Drawing Tablet", price: 4, image: #imageLiteral(resourceName: "tablet"), description: "Much better than using the mouse", levelUnlocked: 5, tileName: "tablet", departmentName: "Graphics"))
        
        self.departments.append(Department(storeName: "TV", price: 8, image: #imageLiteral(resourceName: "TV"), description: "Show the world what to spend money on", levelUnlocked: 7, tileName: "TV", departmentName: "Advertising"))
        
        self.departments.append(Department(storeName: "Desk", price: 10, image:#imageLiteral(resourceName: "desk"), description: "Rule your company with a synergy-powered fist", levelUnlocked: 10, tileName: "desk", departmentName: "Management"))
        
        self.departments.append(Department(storeName: "Safe", price: 12, image: #imageLiteral(resourceName: "safe"), description: "Lock it all up", levelUnlocked: 15, tileName: "safe", departmentName: "Security"))
        
        self.departments.append(Department(storeName: "Phone", price: 15, image: #imageLiteral(resourceName: "phone"), description: "A respectable startup with respectable investors", levelUnlocked: 12, tileName: "phone", departmentName: "Investors"))
        
        
        // COMPONENTS
        self.components.append(Component(storeName: "Spaghetti Code", price: 0.5, image: #imageLiteral(resourceName: "safe"), description: "Gotta start somewhere", levelUnlocked: 0, hours: 0, minutes: 1, department: "Software"))
        
        self.components.append(Component(storeName: "Smooth Scrolling", price: 1.2, image: #imageLiteral(resourceName: "safe"), description: "Slick and polished", levelUnlocked: 2, hours: 0, minutes: 3, department: "Software"))
        
        /*
            self.components.append(Component(storeName: "Search Bar", price: 1, image: #imageLiteral(resourceName: "safe"), description: "It’s like Google, but worse", levelUnlocked: 1, hours: 0, minutes: 1, department: "Software"))
        
        self.components.append(Component(storeName: "Gamification", price: 1.4, image: #imageLiteral(resourceName: "safe"), description: "Everyone likes games", levelUnlocked: 3, hours: 1/30, minutes: 1, department: "Software"))
        
        self.components.append(Component(storeName: "User Stories", price: 3, image: #imageLiteral(resourceName: "safe"), description: "All apps have stories now", levelUnlocked: 10, timeInHours: 1, minutes: 1, department: "Software"))
        
        self.components.append(Component(storeName: "Dope Feature", price: 4, image: #imageLiteral(resourceName: "safe"), description: "Don’t ask questions, just believe", levelUnlocked: 10, timeInHours: 2, department: "Software"))
        
        self.components.append(Component(storeName: "Fancy Code", price: 4, image: #imageLiteral(resourceName: "safe"), description: "inheritance, encapsulation, modular thinking… the works", levelUnlocked: 5, timeInHours: 1/12, department: "Software"))
        
        
        self.components.append(Component(storeName: "Endpoint", price: 1.6, image: #imageLiteral(resourceName: "safe"), description: "The end is nigh", levelUnlocked: 4, timeInHours: 1/60, department: "Backend"))
        
        self.components.append(Component(storeName: "Table", price: 1.4, image: #imageLiteral(resourceName: "safe"), description: "Putting everything on the table", levelUnlocked: 8, timeInHours: 1/6, department: "Backend"))
        
        self.components.append(Component(storeName: "Database", price: 3, image: #imageLiteral(resourceName: "safe"), description: "the backest of the backend", levelUnlocked: 6, timeInHours: 1/2, department: "Backend"))
        
        self.components.append(Component(storeName: "Data Transfer", price: 1.1, image: #imageLiteral(resourceName: "safe"), description: "Share data, not disease", levelUnlocked: 3, timeInHours: 1/12, department: "Backend"))
        
        self.components.append(Component(storeName: "MVC Pattern", price: 1.4, image: #imageLiteral(resourceName: "safe"), description: "Many Volatile Chipmunks", levelUnlocked: 4, timeInHours: 1/4, department: "Backend"))
        
        self.components.append(Component(storeName: "Illustrations", price: 3, image: #imageLiteral(resourceName: "safe"), description: "Make it look pretty", levelUnlocked: 5, timeInHours: 1/6, department: "Graphics"))
        
        self.components.append(Component(storeName: "App Icon", price: 0.5, image: #imageLiteral(resourceName: "safe"), description: "Something pretty to click", levelUnlocked: 2, timeInHours: 1/120, department: "Graphics"))
        
        self.components.append(Component(storeName: "Material Design", price: 1, image: #imageLiteral(resourceName: "safe"), description: "We are living in a material world", levelUnlocked: 5, timeInHours: 1/30, department: "Graphics"))
        
        self.components.append(Component(storeName: "Custom Font", price: 2.4, image: #imageLiteral(resourceName: "safe"), description: "Even cooler than papyrus", levelUnlocked: 5, timeInHours: 1/4, department: "Graphics"))
        
        self.components.append(Component(storeName: "Hip Interface", price: 2.2, image: #imageLiteral(resourceName: "safe"), description: "Get with the times, grandpa", levelUnlocked: 5, timeInHours: 1/4, department: "Graphics"))
        
        self.components.append(Component(storeName: "Word of Mouth", price: 3.8, image: #imageLiteral(resourceName: "safe"), description: "Tell your family, friends, coworkers…", levelUnlocked: 5, timeInHours: 1/4, department: "Advertising"))
        
        self.components.append(Component(storeName: "Ewtube Ads", price: 1.4, image: #imageLiteral(resourceName: "safe"), description: "Annoying, but effective", levelUnlocked: 5, timeInHours: 1/2, department: "Advertising"))
        
        self.components.append(Component(storeName: "Sponsor Hackathon", price: 5, image: #imageLiteral(resourceName: "safe"), description: "It’s gotta be worth something", levelUnlocked: 5, timeInHours: 1, department: "Advertising"))
        
        self.components.append(Component(storeName: "Bumper Stickers", price: 10, image: #imageLiteral(resourceName: "safe"), description: "Because traffic lights are just like commercial breaks", levelUnlocked: 5, timeInHours: 4, department: "Advertising"))
        
        self.components.append(Component(storeName: "TV Commercials", price: 8, image: #imageLiteral(resourceName: "safe"), description: "People still watch TV, right?", levelUnlocked: 5, timeInHours: 3, department: "Advertising"))
        
        self.components.append(Component(storeName: "Weekly Lunch", price: 2, image: #imageLiteral(resourceName: "safe"), description: "Team building over Chipotle", levelUnlocked: 5, timeInHours: 1, department: "Management"))
        
        self.components.append(Component(storeName: "Company Party", price: 4, image: #imageLiteral(resourceName: "safe"), description: "It’s not Christmas until Jerry gets wine drunk and sings Bon Jovi ", levelUnlocked: 5, timeInHours: 1, department: "Management"))
        
        self.components.append(Component(storeName: "Team Shirts", price: 6.9, image: #imageLiteral(resourceName: "safe"), description: "Nothing says cute like a bunch of adults in matching tees.", levelUnlocked: 5, timeInHours: 1/2, department: "Management"))
        
        self.components.append(Component(storeName: "Ideas", price: 0.8, image: #imageLiteral(resourceName: "safe"), description: "Inspiration will strike, eventually", levelUnlocked: 5, timeInHours: 1/120, department: "Ideas"))
        
        self.components.append(Component(storeName: "Knowledge", price: 0.4, image: #imageLiteral(resourceName: "safe"), description: "Learn yourself something useful", levelUnlocked: 5, timeInHours: 1/80, department: "Knowledge"))
        
        self.components.append(Component(storeName: "Security", price: 4, image: #imageLiteral(resourceName: "safe"), description: "Trust a startup with all your valuable personal information", levelUnlocked: 5, timeInHours: 1, department: "Security"))
        
        self.components.append(Component(storeName: "Investor Meeting", price: 2.5, image: #imageLiteral(resourceName: "safe"), description: "Give the people what they want", levelUnlocked: 5, timeInHours: 1/3, department: "Investors"))
        
        self.components.append(Component(storeName: "Hedge Funds", price: 10, image: #imageLiteral(resourceName: "safe"), description: "Mo’ money, mo’ problems", levelUnlocked: 5, timeInHours: 12, department: "Investors"))
        
        self.components.append(Component(storeName: "Focus Group", price: 6, image: #imageLiteral(resourceName: "safe"), description: "Are we out of touch?", levelUnlocked: 5, timeInHours: 6, department: "Investors"))
        */
    }
}
