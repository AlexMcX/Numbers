//
//  View.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

class BaseView: SKScene, Injectable, InjectableHandler {    
    override func sceneDidLoad() {
        initialize()
        
        injection()
        
        onInit()
    }
    
    func onInit() {
        
    }
    
    func onInjection() {
        
    }
}
