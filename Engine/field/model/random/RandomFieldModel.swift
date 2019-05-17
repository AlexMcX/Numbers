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
    public var rangeValue: [ProbabilityModel]?

    private enum CodingKeys: String, CodingKey {
        case startRows = "Start rows"
        case rangeValue = "Range value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.startRows = try container.decode(Int.self, forKey: .startRows)
        self.rangeValue = try container.decode([ProbabilityModel].self, forKey: .rangeValue)

        try super.init(from: decoder)
        
        self.rangeValue = self.rangeValue?.sorted(by: {$0.probability < $1.probability})
    }
}

class ProbabilityModel: Codable {
    public let value: Int
    public let probability: Int
    
    private enum CodingKeys: String, CodingKey {
        case value = "Value"
        case probability = "Probability"
    }
    
    public var description: String {
        return "[ProbabilityModel: value:\(value), probability:\(probability)]"
    }
}
