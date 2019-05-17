//
//  Field+Neighbor.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    private struct neighborCoord {
        static var value: [EGPosition] = [
            EGPosition(row: -1, col: 0),
            EGPosition(row: 0, col: -1),
            EGPosition(row: 0, col: 1),
            EGPosition(row: 1, col: 0)
        ]
    }    
    
    internal func getNeighborTiles(_ row:Int, _ col:Int) -> [Tile] {
        var result: [Tile] = [];

        for coord in neighborCoord.value {
            if let tile = getTile(row: row + coord.row, col: col + coord.col) {
                result.append(tile);
            }
        }
        
        return result
    }
    
    internal func isNeighbors(tiles: [Tile]) -> Bool {
        var prev: Tile?
        
        for tile in tiles {
            if (prev != nil) {
                if (isNeighbors(first: prev!, second: tile) == false) { return false }
            }
            
            prev = tile
        }
        
        return true
    }
    
    internal func isNeighbors(first: Tile, second: Tile) -> Bool {
        let sorted = [first, second].sorted(by: {$0.position.row < $1.position.row})
        let pos: EGPosition = EGPosition(row: sorted[0].position.row - sorted[1].position.row,
                                         col: sorted[0].position.col - sorted[1].position.col)
        
        for coord in neighborCoord.value {
            if (coord == pos) {
                return true
            }
        }
        
        return false
    }
    
    internal func getTile(row: Int, col: Int) -> Tile? {
        if (row < 0 || col < 0 || row >= sceneBaseModel.view.count) { return nil }
        
        let fieldRow = sceneBaseModel.view[row]
    
    
        if (row < sceneBaseModel.field.count) {
            if (col < sceneBaseModel.field[fieldRow].count) {
                return sceneBaseModel.field[fieldRow][col];
            }
        }
        
        return nil;
    }
    
    internal func getRow(fieldIndex index: Int) -> [Tile?] {
        return sceneBaseModel.field[index]
    }
    
    internal func getRow(viewIndex index: Int) -> [Tile?] {
        return getRow(fieldIndex: sceneBaseModel.view[index])
    }
    
    internal func getTiles(isSuccess: Bool) -> [Tile] {
        var row: [Tile?]
        var result: [Tile] = []
        
        for rowIndex in sceneBaseModel.view {
            row = getRow(fieldIndex: rowIndex)
            
            for tile in row {
                if (tile?.isSuccess == isSuccess) {
                    result.append(tile!)
                }
            }
        }
        
        return result
    }
    
    internal func getLastCoord() -> EGPosition {
        var result: EGPosition = EGPosition(row: sceneBaseModel.view.count, col: 0)
        
        base: for (index, fieldIndex) in sceneBaseModel.view.reversed().enumerated() {
            let row = getRow(fieldIndex: fieldIndex)
            
            for (colIndex, tile) in row.reversed().enumerated() {
                if tile == nil {
                    result.row = sceneBaseModel.view.count - index - 1
                    result.col = fieldBaseModel.cols - colIndex - 1
                }else {
                    break base
                }
            }
        }
        
        return result
    }
}
