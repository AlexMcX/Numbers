//
//  Mirror.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 4/24/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

extension Mirror {
    public func childsWithBase() -> [Mirror.Children] {
        var mirror: Mirror? = self
        var result: [Mirror.Children] = []

        while mirror != nil {
            if (mirror!.children.count != 0) {
                result.append(mirror!.children)
            }

            mirror = mirror?.superclassMirror
        }

        return result
    }
}
