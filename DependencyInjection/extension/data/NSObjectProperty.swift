//
//  NSObjectProperty.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/5/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

open class NSObjectProperty {
    internal var data: [(key: String, value: Any)] = []
    
    public func property(forName: String) -> (String, Any)? {
        for property in data {
            if (property.key == forName) {
                return property
            }
        }
        
        return nil
    }
    
    public func enumerated() -> [(key: String, value: Any)] {
        return data
    }
    
    public func keys() -> [String] {
        var result: [String] = []
        
        for prop in data {
            result.append(prop.key)
        }
        
        return result
    }
}
