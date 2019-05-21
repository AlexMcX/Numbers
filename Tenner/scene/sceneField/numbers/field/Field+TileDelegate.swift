//
//  Field+TileDelegate.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field: TileDelegate {
    func selectTile(_ tile: Tile) {
        selectedTiles.append(tile)
        
        if (selectedTiles.count == 2) {
            engineField.step(tiles: selectedTiles.map{$0.model}.compactMap{$0})
        }
    }
    
    func deselesectTile(_ tile: Tile) {
        selectedTiles.removeSafe(tile)
    }
}
