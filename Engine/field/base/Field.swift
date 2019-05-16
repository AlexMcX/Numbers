//
//  GameMode.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/10/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

public class Field: NSObject, INJInjection, FieldProtocol {
    public typealias Tile = TileModel
    @objc dynamic private var fileService: INJFileService!
    @objc dynamic internal var configModel: ConfigModel!
    
    internal var fieldBaseModel: FieldModel!
    internal var sceneBaseModel: SceneModel!
    
    public var delegate: FieldDelegate?
    
    private var levelID: String!
    private var fileName: String!
    private var gamePlay: GamePlay!
    internal var isEndGame: Bool = false
    
    required init(id: String, gamePlay: GamePlay) {
        super.init()
        
        self.levelID = id
        self.gamePlay = gamePlay
        self.fileName = "\(String(describing: id)).level"
        
        injection()
    }
    
    // MARK: INJInjection protocol
    public func onInitialize() {
        fieldBaseModel = fileService.read(plistFile: levelID, to: gamePlay.fieldModel)
       
        if let level = fileService.read(jsonFile: fileName, to: gamePlay.sceneModel) {
            sceneBaseModel = level
        }else {
            sceneBaseModel = SceneModel()
            
            generateScene(value: nil)
        }
        
        #if DEBUG
        startDebug()
        #endif
    }
    
    public func onDeinitialize(){
        sceneBaseModel = nil
    }
    
    internal func generateScene(value: [[Int]]?) {
        guard let idx = value else { return }
        
        var tile: Tile
        
        for (rowIndex, row) in idx.enumerated() {
            for (colIndex, index) in row.enumerated() {
                tile = createTile()
                
                tile.position.row = rowIndex
                tile.position.col = colIndex
                tile.index = index
                
                addToField(tile: tile)
            }
        }   
    }
    
    // MARK: create tile
    internal func createTile() -> Tile {
        let result = Tile.init(id: sceneBaseModel.tilesIDS);
        
        sceneBaseModel.tilesIDS += 1
        
        return result
    }
    
    @discardableResult
    internal func addToField(tile: Tile) -> Bool {
        if (tile.position.row >= fieldBaseModel.rows) { return false }
        
        if (tile.position.row >= sceneBaseModel.view.count) {
            for _ in sceneBaseModel.view.count..<tile.position.row + 1 {
                sceneBaseModel.field.append(Array(repeating: nil, count: fieldBaseModel.cols))
            }
            
            sceneBaseModel.field[sceneBaseModel.field.count - 1][tile.position.col] = tile
            
            sceneBaseModel.view.appendUnigue(sceneBaseModel.field.count - 1)
        }else {
            let fieldIndex = sceneBaseModel.view[tile.position.row]
            
            sceneBaseModel.field[fieldIndex][tile.position.col] = tile
        }
        
        appendToHelp(tile: tile)
        
        return true
    }
}
