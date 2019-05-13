//
//  Position.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public struct EGPosition: Codable, Equatable {
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    init() {
        self.init(row: 0, col: 0)
    }
    
    public var description: String {
        return "[EGPosition: row:\(row), col:\(col)]"
    }
}
