//
//  IInjection.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/25/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public protocol INJInjectable: NSObjectProtocol {
    func injection()
    func uninjection()
    
    // need realization
    func onInitialize()
    func onDeinitialize()
}

public extension INJInjectable {
    func injection() {
        INJInjectingManager.shared.injection(injector: self)
    }
    
    func uninjection() {
        INJInjectingManager.shared.uninjection(injector: self)
    }
}

/*
    Don't dynamic create when init injection protocol
    append to base injection protocol when register instance this protocol
 */
public protocol INJInjectableInstance: INJInjectable {
    func <#name#>()
    func register()
    func unregistration()
}

public extension INJInjectableInstance {
    func register() {
        INJInjectingManager.shared.register(injection: self)
    }
    
    func unregistration() {
        INJInjectingManager.shared.unregister(injection: self)
    }
}

/*
    Only injection propertion, and not include to injection manager
 */
public protocol INJInjection: INJInjectable {}

public protocol INJInjectableHandler: INJInjectable {
    func onInjection()
}
