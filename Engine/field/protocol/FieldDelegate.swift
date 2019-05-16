//
//  FieldDelegate.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public protocol FieldDelegate {
    func onUpdatePrice(stars: Int)
    func onSuccessTiles(tiles: [TileModel])
    func onAddTiles(tiles: [TileModel])
    func onRemoveTiles(tiles: [TileModel])
    func onShiftTiles()
    func onCrowdedField()                       // some tiles not add to field, but is success steps
    func onEndGame()
}
