//
//  SKTexture.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

public extension SKTexture {
    var name: String {
        return self.description.slice(from: " '", to: "' ")
        
    }
}
