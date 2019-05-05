//
//  View.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

class BaseView: SKScene, INJInjectableInstance, INJInjectableHandler {
    @objc dynamic weak internal private(set) var backBtn: Button?
    
    #if DEBUG
    deinit {
        print("     ❇️ BaseView::deinit \(self.className)")
    }
    #else
    #endif
    
    override func onInitialize() {
        isUserInteractionEnabled = false;
        
        preInit()
        
        onInit()
        
        postInit()

        listeners(access: true)
    }
    
    override func onDeinitialize() {
        listeners(access: false)
        
        preDispose()
        
        onDispose()
        
        postDispose()
    }
    
    func onInjection() {
        
    }
    
    func listeners(access: Bool) {
        
    }
    
    // initializators
    func preInit() {}
    func onInit() {}
    func postInit() {}
    
    func preDispose() {}
    func onDispose() {}
    func postDispose() {}
}
