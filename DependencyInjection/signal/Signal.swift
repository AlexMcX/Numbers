//
//  Signal.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class Signal {
    private var slots:[Int:()->Void]!
    private var slotsData:[Int:(Signalable)->Void]!
    
    private var test:[()->Void] = []
    
    public init() {
        slots = [:]
        slotsData = [:]
    }
    
    deinit {
        slots = nil
        slotsData = nil
    }
    
    @discardableResult
    public func add(slot:@escaping ()->Void) -> Int {
        let result = NSUUID().hashValue
        
        slots[result] = slot
        
        return result
    }
    
    @discardableResult
    public func add(slot:@escaping (Signalable)->Void) -> Int {
        let result = NSUUID().hashValue
        
        slotsData[result] = slot
        
        return result
    }
    
    public func remove(id: Int) {
        slots.removeValue(forKey: id)
        
        slotsData.removeValue(forKey: id)
    }
    
    public func fire() {
        for (_, call) in slots {
            call()
        }
    }
    
    public func fire (data:Signalable) {
        for (_, call) in slotsData {
            call(data)
        }
    }
}
