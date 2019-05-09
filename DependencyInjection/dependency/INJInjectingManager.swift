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
        case PROTOCOL(className: String, instance: INJInjectable)
        case PROTOCOL_WAIT(className: String)
        case PROTOCOL_NONE
    }
    
    public static let shared:INJInjecting = INJInjectingManager()
    
    private init() {}
    
    // [className:(Instance, count)]
    private var data:[String: (inst: INJInjectable, count: Int)] = [:]
    
    // [className:wait this class [forKey:InjectionProtocol]]
    private var dataWait:[String: [(String, INJInjectable)]] = [:]
    
    
    
    public func injection(injector:INJInjectable) {
        var isInjection:Bool = true
        
        if (verificationInit(injector)) { return }
        
        let mirror = Mirror(reflecting: injector)
        
        for property in mirror.childsWithBase() {
            for (key, value) in property {
                if (isLazyProperty(key) == true) { continue }
                
                if case Optional<Any>.none = value {
                    let valueType = type(of: value)
                    
                    guard let forKey = key else { continue }
                    
                    // init injection instance
                    let injResult = getInjection(valueType)
                    
                    switch(injResult) {
                        case .PROTOCOL_NONE:
                            continue
                        case .PROTOCOL(let className, let instance):
                            data[className]?.count += 1

                            (injector as! NSObject).setValue(instance, forKey: forKey)
                        case .PROTOCOL_WAIT(let className):
                            addWait(className, forKey, injector)
                        
                            isInjection = false
                    }
                }
            }
        }

        if (isInjection) {
            (injector as? INJInjectableHandler)?.onInjection()
        }
    }
    
    public func uninjection(injector: INJInjectable) {
//        print("   🔆 INJInjectingManager::uninjection \"\(injector.className)\"")

        let mirror = Mirror(reflecting: injector)
        
        for property in mirror.childsWithBase() {
            for (key, value) in property {
                guard let key = key, let value = value as? INJInjectable else { continue }
                
                if (verificationInit(value)) {
                    decrementData(value)
                    
                    (injector as! NSObject).setValue(nil, forKey: key)
                }
            }
        }
        
        decrementData(injector)
    }
    
    public func register(injection:INJInjectable) {
        if (verificationInit(injection) ) {
            fatalError("❌ Error registration \(injection), this instance already exists")
        }
        
        let className = injection.classNameShot
        var dispatch = [INJInjectable]()
        
        if let injectors = dataWait[className] {
            for (forKey, injector) in injectors {
                (injector as! NSObject).setValue(injection, forKey: forKey)
                
                dispatch.append(injector)
            }
            
            dataWait.removeValue(forKey: className)
            
            dispatchInjection(dispatch)
            
            addData(injection)
        }
    }
    
    public func unregister(injection:INJInjectable) {
        print(" TODO !!!!!! unregistration \(injection)")
    }
    
    public func save() {
        for (_, injData) in data {
            if (injData.inst is INJSave) {
                (injData.inst as! INJSave).save()
            }
        }
    }
    
    private func getInjection(_ opt: Any.Type) -> ProtocolStatus {
        let className = (opt as Optional).subjectClassName
        let shotClassName = className.slice(from: ".", removePrefixes: true)
        
        if (isCreatedClass(className)) {
            // find in injection instance
            for (key, info) in data {
                if (key == shotClassName) {
                    return .PROTOCOL(className:shotClassName, instance: info.inst)
                }
            }
        
        
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
        
        // don't dynamic instance create
        if (cls is INJInjection.Type) { return .PROTOCOL_NONE }
        
        var result = data[className]?.inst

        if result == nil {
            if (cls is INJInjectableInstance.Type) {
                return .PROTOCOL_WAIT(className: className)
            }
            
            result = (cls as! NSObject.Type).init() as? INJInjectable
            result?.onInitialize()
            
            addData(result!)
        }
        
        return .PROTOCOL(className:className, instance:result!)
    }
    
    private func addWait(_ className: String, _ forKey: String, _ injector: INJInjectable) {
        if (dataWait[className] == nil) {
            dataWait[className] = [(String, INJInjectable)]()
        }
        
        dataWait[className]?.append((forKey, injector))
    }
    
    private func addData(_ instance: INJInjectable) {
        let className = instance.classNameShot
        
        if (data[className] != nil) { return }
        
        data[className] = (instance, 0)
    }
    
    /*
        decrement "count" instances in data
        if count is 0, remove instance
     */
    private func decrementData(_ instance: INJInjectable) {
        let className = instance.classNameShot
        
        if (data[className] == nil)  { return }
        
        data[className]!.count -= 1
        
        if (data[className]!.count == 0) {
            data[className]?.inst.onDeinitialize()
//
//            data.removeValue(forKey: className)
            
//            print("      << num count \"\(className)\", is 0")
        }
    }    
    
    private func dispatchInjection(_ injectors: [INJInjectable]) {
        for injector in injectors {
            dispatchInjection(injector)
        }
    }
    
    private func dispatchInjection(_ injector: INJInjectable) {
        for (_, wait) in dataWait {
            for (_, instance) in wait {
                if (injector.className == instance.className) { return }
            }
        }
        
        (injector as? INJInjectableHandler)?.onInjection()
    }
    
    private func verificationInit(_ instance: INJInjectable) -> Bool {
        guard let _ = data[instance.classNameShot] else {
            return false
        }
        
        return true
    }
    
    private func isLazyProperty(_ name: String?) -> Bool {
        guard let name = name else { return false }
        
        return name.index(of: ".storage") != nil
    }
    
    private func isCreatedClass(_ className: String) -> Bool {
        let prefixes = ["Swift", "Any", "__C"]
        
        for prefix in prefixes {
            if className.isPrefix(value: prefix) {
                return false
            }
        }
        
        return true
    }
    
    #if DEBUG
    public func printData(_ prefix: String = "") {
        print("       ♻️<<<<<< \(prefix) INJInjectingManager::DATA >>>")
        for (key, info) in data {
            print("         - key:\(key), count:\(info.count)")
        }
        print("       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
    }
    #else
    #endif
}
