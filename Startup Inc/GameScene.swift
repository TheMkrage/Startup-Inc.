//
//  GameScene.swift
//
//  Created by Matthew Krager
//
import SpriteKit
import GameplayKit
//import Presentr

protocol DepartmentTappedProtocol {
    func departmentTapped(named: String)
}

class GameScene: SKScene {
    var map = MapStore.shared.getMap()
    // MARK: Public Properties
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var backgroundLayer: SKTileMapNode!
    
    var placingTileName: String?
    
    var departmentTappedProtocol: DepartmentTappedProtocol?
    
    private var lastUpdateTime : TimeInterval = 0
    
    // MARK: Override Functions
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        guard let backgroundLayer = childNode(withName: "background") as? SKTileMapNode else {
            fatalError("Background node not loaded")
        }
        
        guard let camera = self.childNode(withName: "gameCamera") as? SKCameraNode else {
            fatalError("Camera node not loaded")
        }
        
        self.backgroundLayer = backgroundLayer
        self.camera = camera
        self.backgroundLayer.numberOfColumns = 20
        self.backgroundLayer.numberOfRows = 20
       
        // make squares
        self.backgroundLayer.yScale = self.backgroundLayer.xScale
        guard let tileSet = SKTileSet(named: "Tile Set") else {
            fatalError("NO Tile SET!")
        }
        self.backgroundLayer.tileSet = tileSet
        print(self.backgroundLayer.tileSet.tileGroups)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanFrom(recognizer:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(recognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinchFrom(recognizer:)))
        view.addGestureRecognizer(pinchRecognizer)
        
        self.updateTileSetFromMap()
        NotificationCenter.default.addObserver(self, selector: #selector(hasPurchased(notification:)), name: .init("boughtPlacementItem"), object: nil)
    }
    
    // MARK: - Updating Tiles
    func updateTile(atRow: Int, col: Int) {
        let tile = map.getTile(row: atRow, col: col)
        let tileGroup = self.backgroundLayer.tileSet.tileGroups.first(
            where: {$0.name == tile})
        if tileGroup == nil {
            fatalError("I DONT HAVE THIS TILE")
        }
        self.backgroundLayer.setTileGroup(tileGroup, forColumn: col, row: atRow)
    }
    
    func updateTileSetFromMap() {
        let rows = self.map.rowCount
        let cols = self.map.colCount
        self.backgroundLayer.numberOfRows = rows
        self.backgroundLayer.numberOfColumns = cols
        for r in 0..<rows {
            for c in 0..<cols {
                let tile = map.getTile(row: r, col: c)
                // fetch tile group from included ones,
                let tileGroup = self.backgroundLayer.tileSet.tileGroups.first(
                    where: {$0.name == tile})
                // if none then ERROR
                if tileGroup == nil {
                    fatalError("I DONT HAVE THIS TILE")
                }
                self.backgroundLayer.setTileGroup(tileGroup, forColumn: c, row: r)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // MARK: - Gestures
    var currentScale: CGFloat = 1.0
    
    // MARK: GestureRecognizer functions
    @objc func handlePinchFrom(recognizer: UIPinchGestureRecognizer) {
        let scaledAndCappedVelocity = ((recognizer.velocity < 0 ? -1 : 1) * min(abs(recognizer.velocity) / 4, 0.1))
        // lowest scale is one
        currentScale = min(max(0.45, CGFloat(currentScale) - scaledAndCappedVelocity), 4)
        
        let zoomInAction = SKAction.scale(to: currentScale, duration: 0.0)
        self.camera?.run(zoomInAction)
        //recognizer.scale = 1.0
    }
    
    @objc func handlePanFrom(recognizer: UIPanGestureRecognizer) {
        if recognizer.state != .changed {
            return
        }
        // Get touch delta
        let translation = recognizer.translation(in: recognizer.view!)
        
        // Move camera
        self.camera?.position.x -= translation.x * ( 2 + (currentScale/2))
        self.camera?.position.y += translation.y * ( 2 +
            (currentScale/2))
        // Reset
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
    }
    
    @objc func handleTapFrom(recognizer: UITapGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }
        let location = recognizer.location(in: recognizer.view!)
        let targetLocation = self.convertPoint(fromView: location)
        let layerLocation = self.backgroundLayer.convert(targetLocation, from: self)
        // calculated selected
        let selectCol = self.backgroundLayer.tileColumnIndex(fromPosition: layerLocation)
        let selectRow = self.backgroundLayer.tileRowIndex(fromPosition: layerLocation)
        
        if let placeTile = self.placingTileName {
            print("PLACING AT row \(selectRow) col \(selectCol)")
            self.map.set(tile: placeTile, row: selectRow, col: selectCol)
            self.placingTileName = nil
            self.updateTile(atRow: selectRow, col: selectCol)
        } else {
            print("row \(selectRow) col \(selectCol)")
            
            let tile = self.map.getTile(row: selectRow, col: selectCol)
            if tile != "empty" {
                self.departmentTappedProtocol?.departmentTapped(named: tile)
            }
            self.updateTileSetFromMap()
        }
    }
    
    @objc func hasPurchased(notification: NSNotification) {
        guard let mapTile = notification.userInfo?["tileName"] as? String else {
            fatalError()
        }
        self.placingTileName = mapTile
    }
}
