//
//  Field+EngineDelegate.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/18/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Engine

extension Field: EGFieldDelegate {
    func onStart(view: [[EGTileModel?]]) {
        createField(view: view)
    }
    
    func onUpdatePrice(stars: Int, price: Int, maxPrice: Int) {
        
    }
    
    func onStep(tiles: [EGTileModel], result: Bool) {
        print("Engine call successTiles: \(tiles.map({$0.id})), \(result)")
        
        if (result == false) {
            deselectTilesAnimation()
        }else {
            winTilesAnimation(tiles)
        }
    }
    
    func onAddTiles(tiles: [EGTileModel]) {
        print("Engine call onAddTiles: \(tiles.map({$0.id}))")
        addTile(tiles)
    }
    
    func onRemoveTiles(tiles: [EGTileModel]) {
        print("Engine call onRemoveTiles: \(tiles.map({$0.id}))")
    }
    
    func onShiftTiles() {
        
    }
    
    func onCrowdedField() {
        
    }
    
    func onEndGame() {
        
    }
}
