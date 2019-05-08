//
//  UDSize.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public class UDSize: UserData {
    var width: Int?
    var height: Int?
    var rows: Int?
    var cols: Int?
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case rows
        case cols
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        width = try? container.decode(Int.self, forKey: .width)
        height = try? container.decode(Int.self, forKey: .height)
        
        rows = try? container.decode(Int.self, forKey: .rows)
        cols = try? container.decode(Int.self, forKey: .cols)
        
        try super.init(from: decoder)
    }
}
