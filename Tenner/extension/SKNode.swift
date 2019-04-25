//
//  SKNode.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit
import DependencyInjection

extension SKNode {
    public func initialize() {
        injectionChild()
        
        if (self is INJInjectable) {
            (self as! INJInjectable).injection()
        }
        
        injectUserData()
        
        initChild()
        
        onInitialize()
    }
    
    @objc public func onInitialize() {
        
    }
    
    public func addChildren(in nodes: [SKNode], reg injection: Bool) {
        var property: Mirror.Children? = nil
        
        if (injection) {
            property = Mirror(reflecting: self).children
        }
        
        for node in nodes {
            addChild(node)
            
            if (property != nil) {
                if let nodeName = node.name {
                    for (key, _) in property! {
                        if (key == nodeName) {
                            setValue(node, forKey: key! as String)
                            
                            break
                        }
                    }
                }
            }
        }
    }
    
    public func removeChildren(in nodes: [SKNode], reg injection: Bool) {
        if (injection && nodes.count > 0) {
            let property = Mirror(reflecting: self).children
            
            for node in nodes {
                if let nodeName = node.name {
                    for (key, _) in property {
                        if (key == nodeName) {
                            setValue(nil, forKey: key! as String)
                            
                            break
                        }
                    }
                }
            }
        }
        
        removeChildren(in: nodes)
    }
    
    public func removeAllChildren(reg injection: Bool) {
        removeChildren(in: children, reg: injection)
    }
    
    
    private func injectionChild() {
        let property = Mirror(reflecting: self).children
        
        for (key, _) in property {
            guard let child = childNode(withName: key! as String) else {
                continue
            }
            
            setValue(child, forKey: key! as String)
        }
    }
    
    private func injectUserData() {
        guard let data = userData else { return }
        
        let property = Mirror(reflecting: self).children
        
        for item in data {
            for (key, _) in property {
                if (String(describing: item.key) == key) {
                    setValue(item.value, forKey: key! as String)
                    
                    break
                }
            }
        }
    }
    
    private func initChild() {
        for child in children {
            child.initialize()
        }
    }
}
