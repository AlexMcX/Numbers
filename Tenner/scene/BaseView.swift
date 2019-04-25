//
//  View.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

class BaseView: SKScene, INJInjectable, INJInjectableHandler {
    @objc dynamic weak var backBtn:Button?
    
    override func sceneDidLoad() {
        isUserInteractionEnabled = false;
        
//        initialize()
        
        injection()
        
        onInit()
        
        listeners(access: true)
    }
    
    deinit {
        listeners(access: false)
        
        backBtn = nil
    }
    
    func onInit() {
        
    }
    
    func onInjection() {
        
    }
    
    func listeners(access: Bool) {
        
    }
}
