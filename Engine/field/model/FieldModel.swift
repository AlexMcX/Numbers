//
//  GameModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class FieldModel: Codable {
    public let rows: Int
    public let cols: Int
    public let comparison: Int
    public let minimum: Int
    public let maximum: Int
    public let priceTile: Int
    public let priceRow: Int
    
    enum CodingKeys: String, CodingKey {
        case rows = "Rows"
        case cols = "Cols"
        case comparison = "Comparison"
        case minimum = "Minimum value"
        case maximum = "Maximum value"
        case priceTile = "Price tile"
        case priceRow = "Price row"
    }
}
