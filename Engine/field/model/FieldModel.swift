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
    public let priceComplete: Int
    
    private enum CodingKeys: String, CodingKey {
        case rows = "Rows"
        case cols = "Cols"
        case comparison = "Comparison"
        case minimum = "Minimum value"
        case maximum = "Maximum value"
        case priceTile = "Price tile"
        case priceRow = "Price row"
        case priceComplete = "Price to complete"
    }
    
//    required init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        rows = try container.decode(Int.self, forKey: .rows)
//        cols = try container.decode(Int.self, forKey: .cols)
//        comparison = try container.decode(Int.self, forKey: .comparison)
//        minimum = try container.decode(Int.self, forKey: .minimum)
//        maximum = try container.decode(Int.self, forKey: .maximum)
//        priceTile = try container.decode(Int.self, forKey: .priceTile)
//        priceRow = try container.decode(Int.self, forKey: .priceRow)
//        priceComplete = try container.decode(Int.self, forKey: .priceComplete)
//    }
}
