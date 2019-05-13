//
//  FieldProtocol.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public protocol FieldProtocol {
    associatedtype Tile: TileModel
    
    func help() -> [Tile]
}
