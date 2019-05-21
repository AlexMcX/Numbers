//
//  CacheTile.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/18/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class CacheTile {
    private var cache: [Tile] = []
    
    public var isEmpty: Bool { return cache.count == 0 }
    
    public func add(tile: Tile) {
        if cache.contains(tile) { return }
        
        tile.clear()
        
        cache.append(tile)
    }
    
    public func getFirst() -> Tile? {
        if (cache.count > 0) {
            return cache.removeFirst()
        }
        
        return nil
    }
}
