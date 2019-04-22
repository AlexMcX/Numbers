//
//  NSObject.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 4/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public extension NSObject {
    func setValueSafe(_ value: Any, forKey: String) {
        guard let _ = propertyNames().firstIndex(of:forKey) else { return }
        
        setValue(value, forKey: forKey)
    }
    
    func setValuesForKeysSafe(_ keyedValues: [String : Any]) {
        for (key, value) in keyedValues {
            setValueSafe(value, forKey: key)
        }
    }
    
    func propertyNames() -> Array<String> {
        var result:[String] = []
        var count:UInt32 = 0
        let cl:AnyClass = self.classForCoder
        let properties = class_copyPropertyList(cl, &count)
        
        for i in 0..<count {
            guard let property = properties?[Int(i)] else { continue }
            
            let name = String(cString: property_getName(property))
            
            result.append(name)
        }
        
        free(properties)
        
        return result
    }
}

