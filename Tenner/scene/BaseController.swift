//
//  Controller.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class BaseController: INJController {
    deinit {
        listeners(access: false)
    }
    
    override func postInit() {
        listeners(access: true)
    }
    
    func listeners(access: Bool) {
        
    }
    
}
