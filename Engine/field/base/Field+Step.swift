//
//  Field+Step.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    public func step(tiles: [Tile]) {
        if (isSuccess(tiles: tiles) == false) { return }
        
        var tiles = tiles
        
        successTiles(&tiles)
        
        removeFromHelp(tiles: tiles)
        
        removeSuccessRow(tiles)
        
        delegateSuccessTiles(tiles)
        
        verificationNext()
        
        printFull("STEP - [\(tiles[0].id), \(tiles[1].id)]")
    }
    
    internal func successTiles( _ tiles: inout [Tile]) {
        
    }
    
    private func removeSuccessRow(_ tiles: [Tile]) {
        var row: [Tile] = []
        var rowsIndex = Set<Int>()
        
        for tile in tiles {
            rowsIndex.insert(tile.position.row)
        }
        
        base: for index in rowsIndex {
            row.removeAll()
            
            for tile in getRow(viewIndex: index) {
                if let tile = tile {
                    if (tile.isSuccess == false) {
                        continue base
                    }
                    
                    row.append(tile)
                }
            }
            
            sceneModel.view.removeSafe(index)
            
            delegateRemoveTiles(row)
        }
    }
    
    private func verificationNext() {
        if (success.value.count > 0) { return }
        
        var newTiles: [Tile] = []
        let tiles = getTiles(isSuccess: false)
        
        var newTile: Tile
        var position = getLastCoord()
        
        for tile in tiles {
            newTile = createTile()
            
            newTile.index = tile.index
            newTile.position = position
            
            if addToField(tile: newTile) {
                if (position.col == fieldModel.cols - 1) {
                    position.col = 0
                    position.row += 1
                }else {
                    position.col += 1
                }
                
                newTiles.append(newTile)
            }else {
                delegateAddTiles(newTiles)
                
                if (success.value.count > 0) {
                    delegateCrowdedField()
                }else {
                    delegateEndGame()
                }
                
                return
            }
        }
        
        delegateAddTiles(newTiles)
    }
}
