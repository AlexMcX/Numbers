//
//  InjectionManagerProtocol.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/27/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

protocol INJInjecting {
    func injection(injector:INJInjectable)
    func uninjection(injector:INJInjectable)
    func register(injection:INJInjectable)
    func unregister(injection:INJInjectable)
    func save()
}
