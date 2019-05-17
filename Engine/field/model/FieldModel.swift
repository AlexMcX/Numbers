//
//  GameModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class FieldModel: Decodable {
    let rows: Int
    let cols: Int
    let comparison: Int
    let minimum: Int
    let maximum: Int
    let priceTile: Int
    let priceRow: Int
    let priceComplete: Int
    private var typeValue: [TypeProbabilityModel]?
    
    private enum CodingKeys: String, CodingKey {
        case rows = "Rows"
        case cols = "Cols"
        case comparison = "Comparison"
        case minimum = "Minimum value"
        case maximum = "Maximum value"
        case priceTile = "Price tile"
        case priceRow = "Price row"
        case priceComplete = "Price to complete"
        case typeType = "Range type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)        
        
        self.rows = try container.decode(Int.self, forKey: .rows)
        self.cols = try container.decode(Int.self, forKey: .cols)
        self.comparison = try container.decode(Int.self, forKey: .comparison)
        self.minimum = try container.decode(Int.self, forKey: .minimum)
        self.maximum = try container.decode(Int.self, forKey: .maximum)
        self.priceTile = try container.decode(Int.self, forKey: .priceTile)
        self.priceRow = try container.decode(Int.self, forKey: .priceRow)
        self.priceComplete = try container.decode(Int.self, forKey: .priceComplete)
        self.typeValue = try container.decode([TypeProbabilityModel].self, forKey: .typeType)
    }
    
    func generateType() -> EGTypeProbabilityValue {
        if let types = typeValue {
            if let result = randomProbability(value: types) {
                return (result as! TypeProbabilityModel).value
            }
        }
        
        return .normal
    }
    
    func randomProbability(value: [ProbabilityModel]) -> ProbabilityModel? {
        if (value.count == 0) { return nil}
        
        var filterRanges: [ProbabilityModel] = []
        let sorted = value.sorted(by: {$0.probability < $1.probability})
        let random = Int.randomRange(min: sorted[0].probability, max: sorted[sorted.count - 1].probability)
        
        filterRanges = sorted.filter({$0.probability >= random})
        
        if (filterRanges.count > 0) {
            return filterRanges[Int.randomRange(min: 0, max: filterRanges.count - 1)]
        }        

        return sorted[Int.randomRange(min: 0, max: sorted.count - 1)]
    }
}

class ProbabilityModel: Decodable {
    public let probability: Int
    
    private enum CodingKeys: String, CodingKey {
        case probability = "Probability"
    }
}



class TypeProbabilityModel: ProbabilityModel {
    public let value: EGTypeProbabilityValue
    
    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.value = try container.decode(EGTypeProbabilityValue.self, forKey: .value)
        
        try super.init(from: decoder)
    }
    
    public var description: String {
        return "[ProbabilityModel: value:\(value), probability:\(probability)]"
    }
}

public enum EGTypeProbabilityValue: String, Codable {
    case empty = "Empty"
    case lock = "Lock"
    case normal = "Normal"
}
