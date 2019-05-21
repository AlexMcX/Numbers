//
//  GameMode.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/10/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

public class Field: NSObject, INJInjection, EGField {
    public typealias Tile = EGTileModel
    @objc dynamic private var fileService: INJFileService!
    @objc dynamic internal var configModel: ConfigModel!
    
    internal var fieldBaseModel: FieldModel!
    internal var sceneBaseModel: SceneModel!
    
    public weak var delegate: EGFieldDelegate? {
        didSet {
            delegateStart()
        }
    }
    
    private var TYRY_STEPS_GENERATE_SCENE = 25
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
        
        while TYRY_STEPS_GENERATE_SCENE > 0 {
            for (rowIndex, row) in idx.enumerated() {
                for (colIndex, index) in row.enumerated() {
                    if let tile = createTile(index) {
                        tile.position.row = rowIndex
                        tile.position.col = colIndex
                        
                        addToField(tile: tile)
                    } else {
                        addToField(tile: nil, row: rowIndex, col: colIndex)
                    }
                }
            }
            
            if (success.value.count > 0) {
                break
            }
            
            clear()
            
            TYRY_STEPS_GENERATE_SCENE -= 1
            
            generateScene(value: nil)
            
            return
        }
    }
    
    // MARK: create tile
    internal func createTile(_ index: Int) -> Tile? {        
        let tileType = fieldBaseModel.generateType()
            
        if tileType != .empty {
            let result = Tile.init(id: sceneBaseModel.tilesIDS, type: tileType);
            
            sceneBaseModel.tilesIDS += 1
            
            result.index = index
            
            return result
        }
        
        return nil
    }
    
    @discardableResult
    internal func addToField(tile: Tile) -> Bool {
        let result = addToField(tile: tile, row: tile.position.row, col: tile.position.col)
        
        if (result == true){
            appendToHelp(tile: tile)
        }
        
        return result
    }
    
    @discardableResult
    private func addToField(tile: Tile?, row: Int, col: Int) -> Bool {
        if (row >= fieldBaseModel.rows) { return false }
        
        if (row >= sceneBaseModel.view.count) {
            for _ in sceneBaseModel.view.count..<row + 1 {
                sceneBaseModel.field.append(Array(repeating: nil, count: fieldBaseModel.cols))
            }
            
            sceneBaseModel.field[sceneBaseModel.field.count - 1][col] = tile
            
            sceneBaseModel.view.appendUnigue(sceneBaseModel.field.count - 1)
        }else {
            let fieldIndex = sceneBaseModel.view[row]
            
            sceneBaseModel.field[fieldIndex][col] = tile
        }
        
        return true
    }
    
    private func clear() {
        sceneBaseModel.field.removeAll()
        sceneBaseModel.view.removeAll()
        success.value.removeAll()
    }
}
