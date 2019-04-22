//
//  String.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/26/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public extension String {
    var boolValue:Bool {
        return NSString(string: self).boolValue
    }
    
    /*
         Example:
             self - "Swift.Optional<Project.Service>"
             from - "<"
             to - ">"
     
             return - "Project.Service"
     */
    func slice(from:String, to:String, removePrefixes:Bool = true) -> String {
        guard let sIndex = self.index(of: from),
              let eIndex = self.endIndex(of: to)
        else { return self }
        
        var result:String = self[sIndex..<eIndex]
        
        if removePrefixes {
            result = result[from.count..<result.count - to.count]
        }
        
        return result;
    }
    
    func slice(from:String, removePrefixes:Bool = true) -> String {
        guard let sIndex = self.index(of: from) else { return self }

        var result:String = self[sIndex..<self.endIndex]
        
        if removePrefixes {
            result = result[from.count..<result.count]
        }

        return result
    }
    
    func slice(to:String, removePrefixes:Bool = true) -> String {
        guard let eIndex = self.index(of: to) else { return self }
        
        var result:String = self[self.startIndex..<eIndex]
        
        if removePrefixes {
            result = result[0..<result.count]
        }
        
        return result
    }
    
    func isPrefix(value:String) -> Bool {
        guard index(of: value) != nil else { return false }
        
        return true
    }
    
    subscript (value: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: value.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: value.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
    
    subscript (value: ClosedRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: value.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: value.upperBound)
            
            return String(self[startIndex...endIndex])
        }
    }
    
    subscript (value: Range<String.Index>) -> String {
        get {
            let sDistance = self.distance(from: self.startIndex, to: value.lowerBound)
            let eDistance = self.distance(from: self.startIndex, to: value.upperBound)
            
            return String(self[sDistance..<eDistance])
        }
    }
}
