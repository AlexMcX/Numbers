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
    
    internal var fieldModel: FieldModel!
    internal var sceneModel: SceneModel!
    
    public var delegate: FieldDelegate?
    
    private var fileName: String!
  
    init(fileName: String) {
        super.init()
        
        self.fileName = fileName
        
        injection()
    }
    
    // MARK: INJInjection protocol
    public func onInitialize() {
        if let fileName = fileName {
            fieldModel = fileService.read(plistFile: fileName, to: FieldModel.self)
            
            if let level = fileService.read(jsonFile: "\(String(describing: fileName)).level", to: SceneModel.self) {
                sceneModel = level
            }else {
                sceneModel = SceneModel()
                
                generateScene(value: nil)
            }
        }
        
        #if DEBUG
        startDebug()
        #endif
    }
    
    public func onDeinitialize(){}
    
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
        
        printFull("Field::generateScene")      
    }
    
    // MARK: create tile
    internal func createTile() -> Tile {
        let result = Tile.init(id: sceneModel.tilesIDS);
        
        sceneModel.tilesIDS += 1
        
        return result
    }
    
    @discardableResult
    internal func addToField(tile: Tile) -> Bool {
        if (tile.position.row >= fieldModel.rows) { return false }
        
        if (tile.position.row >= sceneModel.field.count) {
            for _ in sceneModel.field.count..<tile.position.row + 1 {
                sceneModel!.field.append(Array(repeating: nil, count: fieldModel.cols))
            }
        }
        
        sceneModel.field[tile.position.row][tile.position.col] = tile
        
        sceneModel.view.appendUnigue(tile.position.row)
        
        appendToHelp(tile: tile)
        
        return true
    }
}
