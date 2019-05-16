//
//  Field+RemoveTiles.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    internal func shiftTiles(toRemovedRow: Int) {
        var row: [Tile?]
        
        for viewIndex in toRemovedRow..<sceneBaseModel.view.count {
            row = getRow(viewIndex: viewIndex)
            
            for tile in row {
                if let tile = tile {
                    tile.position.row -= 1
                }
            }
        }
    }
}
