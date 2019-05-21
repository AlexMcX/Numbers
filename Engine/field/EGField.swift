//
//  EGField.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/17/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public protocol EGField: class {
//    associatedtype Tile
    
    var delegate: EGFieldDelegate? { get set }
    
    func help() -> [EGTileModel]
    
    func step(tiles: [EGTileModel])
}
