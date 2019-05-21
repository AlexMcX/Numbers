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
            if (tile.isSuccess || tile.type == .lock) { return false }
        }
        
        if (isNeighbors(tiles: tiles) == false) { return false }
        
        if (isSuccess(comparison: tiles) == false) {
            return isSuccess(equatable: tiles)
        }
        
        return true
    }
    
    internal func isSuccess(comparison: [Tile]) -> Bool {
        let total = comparison.reduce(0) { (current, next) -> Int in
            return current + next.index
        }
        
        return total == fieldBaseModel.comparison
    }
    
    internal func isSuccess(equatable: [Tile]) -> Bool {    
        if (equatable.count > 0) {
            return equatable.filter{$0.index != equatable[0].index}.count == 0
        }
        
        return false
    }
}
