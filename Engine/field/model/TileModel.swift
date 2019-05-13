//
//  TileModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public class TileModel: Codable, Equatable {
    public var id: Int = 0
//    public var row: Int = 0
//    public var col: Int = 0
    public var isSuccess: Bool = false
    public var index: Int = 0
    public var position: EGPosition = EGPosition()
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case row
//        case col
//        case isSuccess
//        case index
//    }
    
    required init(id: Int) {
        self.id = id
    }
    
    
    public var description: String {
        return "[TileModel: id:\(id), index:\(index)]"
    }
    
    public static func == (lhs: TileModel, rhs: TileModel) -> Bool {
        return lhs.id == rhs.id
    }
}