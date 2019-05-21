//
//  Field+Delegate.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/14/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Field {
    internal func delegateStart() {
        //#if DEBUG
        //printDelegate(tiles: nil, prefix: "startView")
        //#endif
        
        let result = sceneBaseModel.view.map{ (fieldIndex) -> [Tile?] in
            return getRow(fieldIndex: fieldIndex)
        }
        
        delegate?.onStart(view: result)
    }
    
    internal func delegateStep(_ tiles: [Tile], _ result: Bool) {
//        #if DEBUG
//        printDelegate(tiles: tiles, prefix: "successTiles")
//        #endif
        if (result == true) {
            for tile in tiles {
                tile.isSuccess = true
            }
        }
        
        delegate?.onStep(tiles: tiles, result: result)
    }
    
    internal func delegateRemoveTiles(_ tiles: [Tile]) {
        if (tiles.count > 0) {
//            #if DEBUG
//            printDelegate(tiles: tiles, prefix: "removeTiles")
//            #endif
            
            delegate?.onRemoveTiles(tiles: tiles)
        }
    }
    
    internal func delegateAddTiles(_ tiles: [Tile]) {
        if (tiles.count > 0) {
//            #if DEBUG
//            printDelegate(tiles: tiles, prefix: "addTiles")
//            #endif
            
            delegate?.onAddTiles(tiles: tiles)
        }
    }
    
    internal func delegatePrice(add: Int) {
        sceneBaseModel.price += add
        
        let stars = Int(sceneBaseModel.price * configModel.levelStarsMax / fieldBaseModel.priceComplete)
        
        delegate?.onUpdatePrice(stars: stars, price: sceneBaseModel.price, maxPrice: fieldBaseModel.priceComplete)
        
//        #if DEBUG
//        printDelegate(tiles: nil, prefix: "price: \(stars),  | \(fieldBaseModel.priceComplete),  \(sceneBaseModel.price)")
//        #endif
    }
    
    internal func delegateCrowdedField() {
//        #if DEBUG
//        printDelegate(tiles: nil, prefix: "crowdedField")
//        #endif
        
        delegate?.onCrowdedField()
    }
    
    internal func delegateEndGame() {
        isEndGame = true
        
//        #if DEBUG
//        printDelegate(tiles: nil, prefix: "endGame")
//        #endif
        
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
