//
//  ClassicField.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class ClassicField: Field, ClassicFieldProtocol {
    typealias Tile = ClassicTileModel
    
    private let startIndex = [[1,2,3,4,5,6,7,8,9],
                             [1,1,1,2,1,3,1,4,1],
                             [5,1,6,1,7,1,8,1,9]]
    
    override func generateScene(value: [[Int]]?) {
        super.generateScene(value: startIndex)
    }    
    
}
