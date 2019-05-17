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
    public var rangeValue: [RangeProbabilityModel]?    

    private enum CodingKeys: String, CodingKey {
        case startRows = "Start rows"
        case rangeValue = "Range value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.startRows = try container.decode(Int.self, forKey: .startRows)
        self.rangeValue = try container.decode([RangeProbabilityModel].self, forKey: .rangeValue)

        try super.init(from: decoder)
    }
    
    func generateIndex() -> Int {
        if let types = rangeValue {
            if let result = randomProbability(value: types) {
                return (result as! RangeProbabilityModel).value
            }
        }
        
        return Int.randomRange(min: minimum, max: maximum)
    }
}



class RangeProbabilityModel: ProbabilityModel {
    public let value: Int
    
    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.value = try container.decode(Int.self, forKey: .value)
        
        try super.init(from: decoder)
    }
    
    public var description: String {
        return "[RangeProbabilityModel: value:\(value), probability:\(probability)]"
    }
}
