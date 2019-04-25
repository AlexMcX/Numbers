//
//  IInjection.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/25/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public protocol INJInjectableHandler: INJInjectable {
    func onInjection()
}

/*
    Don't dynamic create when init injection protocol
    append to base injection protocol when register instance this protocol
 */
public protocol INJInjectableInstance: INJInjectable {
    func register()
}

public extension INJInjectableInstance {
    func register() {
        INJInjectingManager.shared.register(injection: self)
    }
}

/*
    Only injection propertion, and not include to injection manager
 */
public protocol INJInjection: INJInjectable {}


public protocol INJInjectable: NSObjectProtocol {
    func injection()
    func unregistration()
//    func onInit()
}

public extension INJInjectable {    
    func injection() {
        INJInjectingManager.shared.injection(injector: self)
    }
    
    func unregistration() {
        INJInjectingManager.shared.unregister(injection: self)
    }
}
