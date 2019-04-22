//
//  Bool.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

extension Bool {
    
    static public var random: Bool {
        get {
            return Int.randomRange(min:0, max:1) == 0 ? false : true;
        }
    }
}
