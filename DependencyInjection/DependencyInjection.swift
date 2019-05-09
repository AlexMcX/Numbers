//
//  DependencyInjection.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 5/9/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public class DependencyInjection {
    static let injection = INJInjectingManager.shared
    
    public static func save() {
        DependencyInjection.injection.save()
    }
}
