//
//  Renderer.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public class UDRenderer: UserData {
    var renderer: String?
    var library: String?
    
    enum CodingKeys: String, CodingKey {
        case renderer
        case library
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        renderer = try? container.decode(String.self, forKey: .renderer)
        library = try? container.decode(String.self, forKey: .library)

        try super.init(from: decoder)
    }
}
