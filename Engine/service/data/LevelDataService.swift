//
//  LevelDataService.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection
import CoreData

open class LevelDataService: INJDataService {
//    @objc dynamic private var configService: ConfigService!
    
    private lazy var levelsData: [Level] = { return fetch() as! [Level] }()
    
    override open func onInit() {
        initModel(containerName: "Progress", entityName: "Level", managedObjectClass: Level.self)
    }
    
    
}
