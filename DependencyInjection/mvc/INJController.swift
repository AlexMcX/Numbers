//
//  BaseController.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJController: NSObject, INJInjectable, INJInjectableHandler {
    public override init() {
        super.init()
        
        injection()
        
        preInit()
        
        onInit()
        
        postInit()
    }
    
    open func preInit() {
        
    }
    
    open func onInit() {
 
    }
    
    open func postInit() {
        
    }
    
    open func onInjection() {
        
    }
}

