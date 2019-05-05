//
//  Service.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJService: NSObject, INJInjectable, INJInjectableHandler {
    
    override public init() {
        super.init()
        
        injection()
    }
    
    #if DEBUG
    deinit {
        print("     ❇️ INJService::deinit \(self.className)")
    }
    #else
    #endif
    
    public func onInitialize() {
        preInit()
        
        onInit()
        
        postInit()
    }
    
    public func onDeinitialize() {
        preDispose()
        
        onDispose()
        
        postDispose()
    }
    
    // initializators
    open func preInit() {}
    open func onInit() {}
    open func postInit() {}
    
    // deinitializator
    open func preDispose() {}
    open func onDispose() {}
    open func postDispose() {}
    
    open func onInjection() {
        
    }
}
