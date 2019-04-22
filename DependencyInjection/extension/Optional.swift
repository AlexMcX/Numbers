//
//  Optional.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/25/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public extension Optional {
    var subjectClassName:String {
        get {
            let description:String = String(describing: self)
            
            return description.slice(from: "<", to: ">")
        }
    }
}
