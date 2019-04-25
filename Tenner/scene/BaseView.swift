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
    @objc dynamic weak internal private(set) var backBtn:Button?
    
    deinit {
        listeners(access: false)
        
        backBtn = nil
    }
    
    override func onInitialize() {
        isUserInteractionEnabled = false;
        
        onInit()

        listeners(access: true)
    }
    
    func onInit() {
        
    }
    
    func onInjection() {
        
    }
    
    func listeners(access: Bool) {
        
    }
}
