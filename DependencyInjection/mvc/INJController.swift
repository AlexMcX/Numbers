//
//  BaseController.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJController: NSObject, INJInjectable, INJInjectableHandler {
    
    public private(set) weak var view: UIResponder!
    
    required public init(view: UIResponder) {
        super.init()
        
        self.view = view
        
        injection()
    }
    
    deinit {
        uninjection()
    }
    
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
    
    open func onInjection() {}
    
    // initializators
    open func preInit() {}
    open func onInit() {}
    open func postInit() {}
    
    // deinitializator
    open func preDispose() {}
    open func onDispose() {}
    open func postDispose() {}
}

