//
//  TileModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public class EGTileModel: Codable, Equatable {
    public var id: Int = 0
    public var isSuccess: Bool = false
    public var index: Int = 0
    public var position: EGPosition = EGPosition()
    public var type: EGTypeProbabilityValue
    
    required init(id: Int, type: EGTypeProbabilityValue) {
        self.id = id
        self.type = type
    }
    
    public var description: String {
        return "[TileModel: id:\(id), index:\(index)]"
    }
    
    public static func == (lhs: EGTileModel, rhs: EGTileModel) -> Bool {
        return lhs.id == rhs.id
    }
}
