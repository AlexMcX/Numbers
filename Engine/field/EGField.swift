//
//  EGField.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/17/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public protocol EGField {
    func help() -> [TileModel]
    
    func step(tiles: [TileModel])
}
