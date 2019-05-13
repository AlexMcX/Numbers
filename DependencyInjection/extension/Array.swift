//
//  Array.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 5/13/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

extension Array where Element: Hashable{
    public mutating func appendUnigue(_ newElement: Element) {
        if firstIndex(of: newElement) == nil {
            append(newElement)
        }
    }
    
    public mutating func removeSafe(_ newElement: Element) {
        if let index = firstIndex(of: newElement) {
            remove(at: index)
        }
    }
}
