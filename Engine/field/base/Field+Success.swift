//
//  Field+Success.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    internal func isSuccess(tiles: [Tile]) -> Bool {
        for tile in tiles {
            if (tile.isSuccess) { return false }
        }
        
        if (isNeighbors(tiles: tiles) == false) { return false }
        
        if (isSuccess(comparison: tiles) == false) {
            return isSuccess(equatable: tiles)
        }
        
        return true
    }
    
    internal func isSuccess(comparison: [Tile]) -> Bool {
        var total: Int = 0
        
        for tile in comparison {
            total += tile.index
        }
        
        return total == fieldBaseModel.comparison
    }
    
    internal func isSuccess(equatable: [Tile]) -> Bool {
        var prev: Tile?
        
        for tile in equatable {
            if (prev != nil) {
                if (prev!.index != tile.index) { return false }
            }
            
            prev = tile
        }
        
        return true
    }
}
