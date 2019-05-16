//
//  Field+Delegate.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/14/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    internal func delegateSuccessTiles(_ tiles: [Tile]) {
        #if DEBUG
        printDelegate(tiles: tiles, prefix: "successTiles")
        #endif
        
        for tile in tiles {
            tile.isSuccess = true
        }
        
        delegate?.onSuccessTiles(tiles: tiles)
    }
    
    internal func delegateRemoveTiles(_ tiles: [Tile]) {
        if (tiles.count > 0) {
            #if DEBUG
            printDelegate(tiles: tiles, prefix: "removeTiles")
            #endif
            
            delegate?.onRemoveTiles(tiles: tiles)
        }
    }
    
    internal func delegateAddTiles(_ tiles: [Tile]) {
        if (tiles.count > 0) {
            #if DEBUG
            printDelegate(tiles: tiles, prefix: "addTiles")
            #endif
            
            delegate?.onAddTiles(tiles: tiles)
        }
    }
    
    internal func delegatePrice(add: Int) {
        sceneBaseModel.price += add
        
        let stars = Int(sceneBaseModel.price * configModel.levelStarsMax / fieldBaseModel.priceComplete)
        
        delegate?.onUpdatePrice(stars: stars)
        
        #if DEBUG
        printDelegate(tiles: nil, prefix: "price: \(stars),  | \(fieldBaseModel.priceComplete),  \(sceneBaseModel.price)")
        #endif
    }
    
    internal func delegateCrowdedField() {
        #if DEBUG
        printDelegate(tiles: nil, prefix: "crowdedField")
        #endif
        delegate?.onCrowdedField()
    }
    
    internal func delegateEndGame() {
        isEndGame = true
        
        #if DEBUG
        printDelegate(tiles: nil, prefix: "endGame")
        #endif
        delegate?.onEndGame()
    }
    
     #if DEBUG
    private func printDelegate(tiles: [Tile]?, prefix: String) {
        var result: String = ""
        
        if let tiles = tiles {
            for (index, tile) in tiles.enumerated() {
                result += "\(tile.id)"
                
                result += index < tiles.count - 1 ? ", " : ""
            }
        }
        
        print("🔔 DELEGATE ENGINE \(prefix): \(result)")
    }
    #endif
}
