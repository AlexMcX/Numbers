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
        
        onInit()
    }
    
    open func onInit() {

    }
    
    public func onInjection() {
        
    }
}
