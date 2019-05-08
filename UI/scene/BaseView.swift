//
//  View.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

open class BaseView: SKScene, INJInjectableInstance, INJInjectableHandler {
    @objc dynamic weak internal private(set) var backBtn: Button?
    
    #if DEINIT
    deinit {
        print("     ❇️ BaseView::deinit \(self.className)")
    }
    #else
    #endif
    
    override public func onInitialize() {
        isUserInteractionEnabled = false;
        
        preInit()
        
        onInit()
        
        postInit()

        listeners(access: true)
    }
    
    override public func onDeinitialize() {
        listeners(access: false)
        
        preDispose()
        
        onDispose()
        
        postDispose()
    }
    
    public func onInjection() {
        
    }
    
    open func listeners(access: Bool) {
        
    }
    
    // initializators
    open func preInit() {}
    open func onInit() {}
    open func postInit() {}
    
    open func preDispose() {}
    open func onDispose() {}
    open func postDispose() {}
}
