//
//  Field.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/17/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import Engine

class Field: UIComponent {
    @objc dynamic weak private var engine: Engine!
    
    internal lazy var engineField: EGField = { engine.field }()
    
    internal var field: [[Tile?]] = []
    internal var cache: CacheTile = CacheTile()
    
    internal var selectedTiles: [Tile] = []
    
    override func onInit() {
        engineField.delegate = self
    }
    
    func createField(view: [[EGTileModel?]]) {
        for row in view {
            for model in row {
                if let model = model {
                   addTile(model)
                }
            }
        }

        printFull()
    }

}
