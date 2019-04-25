//
//  DependencyInjection.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/26/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class INJInjectingManager: INJInjecting {
    private enum ProtocolStatus {
        case PROTOCOL(instance:INJInjectable)
        case PROTOCOL_WAIT(className:String)
        case PROTOCOL_NONE
    }
    
    public static let shared:INJInjecting = INJInjectingManager()
    
    private init() {}
    
    // [className:Instance]
    private var data:[String: INJInjectable] = [:]
    
    // [className:wait this class [forKey:InjectionProtocol]]
    private var dataWait:[String: [(String, INJInjectable)]] = [:]
    
    private var injectionInit:[INJInjectable] = []
    
    public func injection(injector:INJInjectable) {
        var isInjection:Bool = true
        
        if (verificationInit(injector)) { return }
        
        // append when injector is not INJInjection protocol
        if (injector is INJInjection == false) {
            injectionInit.append(injector)
        }
        
        let mirror = Mirror(reflecting: injector)
        
        for property in mirror.childsWithBase() {
            for (key, value) in property {
                let valueType = type(of: value)
                
                guard let forKey = key else { continue }
                
                // init injection instance
                let injResult = getInjection(valueType)
                
                switch(injResult) {
                    case .PROTOCOL_NONE:
                        continue
                    case .PROTOCOL(let instance):
                        (injector as! NSObject).setValue(instance, forKey: forKey)
                    case .PROTOCOL_WAIT(let className):
                        addWait(className, forKey, injector)
                    
                        isInjection = false
                }
            }
        }
    
        if (isInjection) {
            (injector as? INJInjectableHandler)?.onInjection()
        }
    }
    
    public func register(injection:INJInjectable) {
        if (verificationInit(injection) ) {
            fatalError("❌ Error registration \(injection), this instance already exists")
        }
        
        let className = getInjectionClassName(injection)
        var dispatch = [INJInjectable]()
        
        if let injectors = dataWait[className] {
            for (forKey, injector) in injectors {
                (injector as! NSObject).setValue(injection, forKey: forKey)
                
                dispatch.append(injector)
            }
            
            dataWait.removeValue(forKey: className)
            
            dispatchInjection(dispatch)
            
            injectionInit.append(injection)
        }
    }
    
    public func unregister(injection:INJInjectable) {
        print(" TODO !!!!!! unregistration \(injection)")
    }
    
    private func getInjection(_ opt: Any.Type) -> ProtocolStatus {
        let className = (opt as Optional).subjectClassName
        let shotClassName = className.slice(from: ".", removePrefixes: true)
        
        // find in injection instance
        for inst in injectionInit {
            if (getInjectionClassName(inst) == shotClassName) {
                return .PROTOCOL(instance: inst)
            }
        }
        
        
        if !className.isPrefix(value: "Swift") {
            guard let cls = NSClassFromString(className) as? INJInjectable.Type else {
                guard let cls = NSClassFromString(shotClassName) as? INJInjectable.Type else {
                    return .PROTOCOL_NONE
                }
                
                return initInjection(cls)
            }
            
            return initInjection(cls)
        }
        
        return .PROTOCOL_NONE
    }
    
    private func initInjection(_ cls: INJInjectable.Type) -> ProtocolStatus {
        let className:String = String(describing: cls)
        
        var result = data[className]

        if result == nil {
            if (cls is INJInjectableInstance.Type) {
                return .PROTOCOL_WAIT(className: className)
            }
            
            result = (cls as! NSObject.Type).init() as? INJInjectable
            
            addData(instance: result!)
        }

        return .PROTOCOL(instance:result!)
    }
    
    private func addWait(_ className: String, _ forKey: String, _ injector: INJInjectable) {
        if (dataWait[className] == nil) {
            dataWait[className] = [(String, INJInjectable)]()
        }
        
        dataWait[className]?.append((forKey, injector))
    }
    
    private func addData(instance: INJInjectable) {
        let className = getInjectionClassName(instance)
        
        if (data[className] != nil) { return }
        
        data[className] = instance
    }
    
    
    private func dispatchInjection(_ injectors: [INJInjectable]) {
        for injector in injectors {
            dispatchInjection(injector)
        }
    }
    
    private func dispatchInjection(_ injector: INJInjectable) {
        for (_, wait) in dataWait {
            for (_, instance) in wait {
                if (getInjectionClassName(injector) == getInjectionClassName(instance)) { return }
            }
        }
        
        (injector as? INJInjectableHandler)?.onInjection()
    }   
    
    private func getInjectionClassName(_ instance: INJInjectable) -> String {
        return String(describing: Mirror(reflecting: instance).subjectType)
    }
    
    private func verificationInit(_ instance: INJInjectable) -> Bool {
        for inst in injectionInit {
            if (getInjectionClassName(instance) == getInjectionClassName(inst)) { return true }
        }
        
        return false
    }
}
