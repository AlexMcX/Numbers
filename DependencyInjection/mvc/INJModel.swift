//
//  Model.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/25/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJModel: NSObject, INJInjectable {
    override init() {
        super.init()
        
        initialize()
    }
    
    open func onInit() {
        
    }
    
    open func dispose() {
        
    }
    
    private func initialize() {
        injection()
        
        onInit();
    }
}
