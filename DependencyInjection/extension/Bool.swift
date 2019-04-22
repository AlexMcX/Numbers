//
//  Bool.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 4/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

public extension Bool {
    init(_ value: Int) {
        switch value {
        case 1:
            self.init(true)
        default:
            self.init(false)
        }
    }
    
    init(_ value: String) {
        switch value.lowercased() {
        case "true", "yes", "1":
            self.init(true)
        default:
            self.init(false)
        }
    }
}
