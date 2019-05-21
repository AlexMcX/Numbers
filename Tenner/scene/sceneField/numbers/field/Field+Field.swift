//
//  Field+Field.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/18/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Engine
import Foundation

extension Field {    
    func addTile(_ tile: Tile) {
        tile.position.x = CGFloat(tile.model!.position.col * Int(tile.calculateSize.width))
        tile.position.y = -CGFloat(tile.model!.position.row * Int(tile.calculateSize.height))
        
        addChildren(in: tile, reg: true)
    }
    
    func addTile(_ model: EGTileModel) {
        let tile = createTile(model: model)
        
        tile.delegate = self
        
        addTile(tile)
    }
    
    func addTile(_ models: [EGTileModel]) {
        for model in models {
            addTile(model)
        }
    }
    
    func removeTile(tile: Tile) {
        
    }
    
    private func createTile(model: EGTileModel) -> Tile {
        let result = cache.getFirst() ?? libService.getChild(library: "SceneLib", renderer: "tile") as! Tile
        
        result.setModel(model)
        
        return result
    }
}
