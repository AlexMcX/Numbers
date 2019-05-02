//
//  Paddings.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class UDPadding: UserData {
    var x: Int?
    var y: Int?
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        x = try container.decode(Int.self, forKey: .x)
        y = try container.decode(Int.self, forKey: .y)
        
        try super.init(from: decoder)
    }
}
