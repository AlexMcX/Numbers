//
//  SKNode.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    public func initialize() {
        injectionChild()
    }
    
    private func injectionChild() {
        let property = Mirror(reflecting: self).children
        
        for (key, _) in property {
            guard let child = childNode(withName: key! as String) else { continue }
            
            setValue(child, forKey: key! as String)
        }
    }
    
    
}
