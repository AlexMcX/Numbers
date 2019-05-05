//
//  NSObjectProtocol.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 5/5/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {
    var className: String {
        return String(describing: Mirror(reflecting: self).subjectType)
    }
    
    var classNameShot: String {
        return className.slice(from: ".", removePrefixes: true)
    }
}
