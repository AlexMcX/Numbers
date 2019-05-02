//
//  Enhine.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

open class Engine: NSObject, INJInjection {
    @objc dynamic public private(set) var blockDataService: BlockDataService!
    @objc dynamic public private(set) var levelsDataService: LevelDataService!
    @objc dynamic private var configService: ConfigService!
    
    public var totalStars: Int { return blockDataService.totalStars }
    
    override init() {
        super.init()
        
        initialize()
    }
    
    public func onInit() {
        
    }
    
    public func initConfig(fileName: String) {
        configService.initConfig(fileName: fileName)
    }
    
    private func initialize() {
        injection()
        
        onInit();
    }
}
