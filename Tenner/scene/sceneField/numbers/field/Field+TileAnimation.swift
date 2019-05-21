//
//  Field+TileAnimation.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Engine
import Foundation

extension Field {
    func deselectTilesAnimation() {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: DispatchTime.now() + 0.7) {
            for tile in self.selectedTiles {
                tile.selected = false
            }
            
            self.selectedTiles.removeAll()
        }
    }
    
    func winTilesAnimation(_ tiles: [EGTileModel]) {
        self.selectedTiles.removeAll()
    }
}
