//
//  Field+Step.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    public func step(tiles: [Tile]) {
        if (isEndGame || isSuccess(tiles: tiles) == false) { return }
        
        var tiles = tiles
        
        delegatePrice(add: fieldBaseModel.priceTile)
        
        successTiles(&tiles)
        
        removeFromHelp(tiles: tiles)
        
        delegateSuccessTiles(tiles)
        
        removeSuccessRow(tiles)
        
        verification()
    }
    
    internal func successTiles( _ tiles: inout [Tile]) {
        
    }
    
    private func removeSuccessRow(_ tiles: [Tile]) {
        var row: [Tile] = []
        var rowsIndex: [Int] = []
        var removeIndex: [Int] = []
        var removeTiles: [Tile] = []
        
        for tile in tiles {
            rowsIndex.appendUnigue(tile.position.row)
        }
        
        rowsIndex = rowsIndex.sorted(by: {$0 < $1})
        
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
            
            removeIndex.append(index)
            
            removeTiles += row
        }
        
        if (removeIndex.count == 0) { return }
        
        for index in removeIndex {
            sceneBaseModel.view.removeSafe(sceneBaseModel.view[index])
            
            shiftTiles(toRemovedRow: index)
        }
        
        delegatePrice(add: fieldBaseModel.priceRow * removeIndex.count)
        
        delegateRemoveTiles(removeTiles)
        
    }
    
    private func verification() {
        // win max count price
        if (sceneBaseModel.price >= fieldBaseModel.priceComplete) {
            delegateEndGame()
            
            return
        }
        
        if (success.value.count > 0) { return }
        
        verificationNext()
    }
    
    private func verificationNext() {
        var newTiles: [Tile] = []
        let tiles = getTiles(isSuccess: false)
   

        var position = getLastCoord()
        
        for tile in tiles {
            if let newTile = createTile(tile.index) {
                newTile.position = position
                
                if addToField(tile: newTile) {
                    if (position.col == fieldBaseModel.cols - 1) {
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
        }

        delegateAddTiles(newTiles)
    }
}
