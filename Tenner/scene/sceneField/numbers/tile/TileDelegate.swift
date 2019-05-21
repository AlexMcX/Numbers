//
//  TileDelegate.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/19/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Engine

protocol TileDelegate: class {
    func selectTile(_ tile: Tile)
    func deselesectTile(_ tile: Tile)
}
