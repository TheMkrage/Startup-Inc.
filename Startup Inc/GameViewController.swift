//
//  GameViewController.swift
//  Startup Inc
//
//  Created by Matthew Krager on 11/30/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Presentr

class GameViewController: UIViewController {
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var xpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moneyChanged()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(moneyChanged), name: .init("moneyChanged"), object: nil)
    }
    
    @IBAction func storeTab(_ sender: Any) {
        guard let tabController = self.storyboard?.instantiateViewController(withIdentifier: "StoreTab") as? StoreTabViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: tabController)
        let presentr = Presentr(presentationType: .popup)
        presentr.backgroundOpacity = 0.45
        self.customPresentViewController(presentr, viewController: nav, animated: true, completion: nil)
    }
    
    @IBAction func activeApps(_ sender: Any) {
        
    }
    
    @IBAction func activeTowers(_ sender: Any) {
        
    }
    
    @IBAction func achievments(_ sender: Any) {
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func moneyChanged() {
        self.moneyLabel.text = "\(MoneyStore.shared.money)k"
    }
}
