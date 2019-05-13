//
//  Int.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
    static public var random: Int {
        get {
            return Int.randomRange(min: Int.min, max: Int.max);
        }
    }
    
    static public func randomRange (min:Int, max:Int) -> Int {
        var result:Int = 0;
        
        while true {
            result = Int(arc4random_uniform(UInt32(max + 1))) + min;
            
            if result <= max { break };
        }
        
        return result;
    }
}
