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

public extension SKNode {
    func initialize() {
        let props = properties()
        
        injectionChild(props, false)
        
        injectUserData(props, false)
        
        initChild()
        
        if (self is INJInjectable) {
            (self as! INJInjectable).injection()
        }else {
            onInitialize()
        }
    }
    
    func deinitialize() {
        let props = properties()
        
        onDeinitialize()
        
        if (self is INJInjectable) {
            (self as! INJInjectable).uninjection()
        }
        
        injectionChild(props, true)
        
        injectUserData(props, true)
        
        initChild(true)
    }
    
    @objc func onInitialize() {}
    
    @objc func onDeinitialize() {}
    
    
    func addChildren(in node: SKNode, reg injection: Bool) {
        addChildren(in: [node], reg: injection)
    }
    
    func addChildren(in nodes: [SKNode], reg injection: Bool) {
        var mirrors: [Mirror.Children]?
        
        if (injection) {
            mirrors = Mirror(reflecting: self).childsWithBase()
        }
        
        for node in nodes {
            if (mirrors != nil) {
                if let nodeName = node.name {
                    mirrorLoop: for property in mirrors! {
                        for (key, _) in property {
                            if (key == nodeName) {
                                setValue(node, forKey: key! as String)
                                
                                break mirrorLoop
                            }
                        }
                    }
                }
            }
            
            node.initialize()
            
            addChild(node)
        }
    }
    
    func removeChildren(in node: SKNode, reg injection: Bool) {
        removeChildren(in: [node], reg: injection)
    }
    
    func removeChildren(in nodes: [SKNode], reg injection: Bool) {
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
    
    func removeAllChildren(reg injection: Bool) {
        removeChildren(in: children, reg: injection)
    }
    
    
    private func injectionChild(_ properties: NSObjectProperty, _ isClear: Bool) {
        for key in properties.keys() {
            guard let child = childNode(withName: key) else { continue }
            
            setValue(isClear ? nil : child, forKey: key)
        }
    }
    
    private func injectUserData(_ properties: NSObjectProperty, _ isClear: Bool) {
        guard let data = userData else { return }

        for item in data {
            for (key, value) in properties.enumerated() {
                if (String(describing: item.key) == key) {
                    if decodeUserData(key: key, value: value, data: "\(item.value)") == false {
                        setValue(isClear ? nil : item.value, forKey: key)
                    }

                    break
                }
            }
        }
    }
    
    private func initChild(_ isClear: Bool = false) {
        for child in children {
            if(isClear) {
                child.deinitialize()
            }else {
                child.initialize()
            }
        }
    }
    
    private func decodeUserData(key: String, value: Any, data: String) -> Bool {
        let valueType = type(of: value)
        let className = (valueType as Optional).subjectClassName
        
        if !className.isPrefix(value: "Swift") {
            guard let cls = NSClassFromString(className) as? UserData.Type else { return false }
            
            guard let decode = try? JSONDecoder().decode(cls, from: data.data(using: .utf8)!) else {
                let inst = (cls as NSObject.Type).init() as? UserData
                do{
                    try inst!.customDecode(value: data)
                    
                    setValue(inst, forKey: key)
                    
                    return true
                }catch {
                   return false
                }
            }
            
            setValue(decode, forKey: key)
            
            return true
        }
        
        return false
    }
}
