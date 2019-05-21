//
//  FieldDelegate.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public protocol EGFieldDelegate: class {
    func onStart(view: [[EGTileModel?]])
    func onStep(tiles: [EGTileModel], result: Bool)
    func onUpdatePrice(stars: Int, price: Int, maxPrice: Int)
    func onAddTiles(tiles: [EGTileModel])
    func onRemoveTiles(tiles: [EGTileModel])
    func onShiftTiles()
    func onCrowdedField()                       // some tiles not add to field, but is success steps
    func onEndGame()
}
