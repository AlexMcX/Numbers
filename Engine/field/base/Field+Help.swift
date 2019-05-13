//
//  Field+Help.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    internal struct success{ static var value: [[Tile]] = [] }
    
    public func help() -> [Tile] {
        return success.value.count > 0 ? success.value[Int.randomRange(min: 0, max: success.value.count - 1)] : []
    }
        
    internal func initHelp() {
        for row in sceneModel.field {
            appendToHelp(tiles: row)
        }
    }
    
    internal func appendToHelp(tiles: [Tile?]) {
        for tile in tiles {
            if let tile = tile {
                appendToHelp(tile: tile)
            }
        }
    }
    
    internal func appendToHelp(tile: Tile) {
        let neighbors = getNeighborTiles(tile.position.row, tile.position.col)
        
        base: for neighbor in neighbors {
            if (isSuccess(tiles: [tile, neighbor])) {
                for group in success.value {
                    if (group.firstIndex(of: tile) != nil &&
                        group.firstIndex(of: neighbor) != nil) {
                        
                        continue base
                    }
                }
                
                success.value.append([tile, neighbor])
            }
        }
    }
    
    internal func removeFromHelp(tiles: [Tile]) {
        for tile in tiles {
            removeFromHelp(tile: tile)
        }
    }
    
    internal func removeFromHelp(tile: Tile) {
        var index: Int = 0
        
        base: while true {
            for i in index..<success.value.count {
                if (success.value[i].firstIndex(of: tile) != nil) {
                    index = i == 0 ? 0 : i - 1
                    
                    success.value.remove(at: i)
                    
                    continue base
                }
            }
            
            break
        }
    }
}
