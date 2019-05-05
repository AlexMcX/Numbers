//
//  INJInstanceModel.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJInstanceModel: NSObject, INJInjectableInstance {
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
}
