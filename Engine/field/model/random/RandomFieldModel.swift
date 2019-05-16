//
//  RandomFieldModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class RandomFieldModel: FieldModel {
    public var startRows: Int = 0
    public var rangeValue: [Int]?

    private enum CodingKeys: String, CodingKey {
        case startRows = "Start rows"
        case rangeValue = "Range value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.startRows = try container.decode(Int.self, forKey: .startRows)
        self.rangeValue = try container.decode([Int].self, forKey: .rangeValue)

        try super.init(from: decoder)
    }
}
