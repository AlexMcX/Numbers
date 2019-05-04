//
//  Enhine.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

open class Engine: NSObject, INJInjectable {
    @objc dynamic private(set) var blockDataService: BlocksDataService!
    @objc dynamic private(set) var levelsDataService: LevelsDataService!
    @objc dynamic private var configService: ConfigService!
    
    public var totalStars: Int { return blockDataService.totalStars }
    
    override init() {
        super.init()
        
        initialize()
    }
    
    public func onInit() {
        
    }
    
    public func dispose() {
        
    }
    
    public func initConfig(fileName: String) {
        configService.initConfig(fileName: fileName)
    }
    
    public func initBlock(id: String?) {
        blockDataService.currentID = id
        levelsDataService.currentBlockID = id
    }
    
    public func initLevel(id: String?) {
        levelsDataService.currentID = id
    }
    
    public func getBlocks() -> [BlockModel] {
        return blockDataService.blocks
    }
    
    public func getLevels() -> [LevelModel] {
        return levelsDataService.levels
    }
    
    private func initialize() {
        injection()
        
        onInit();
    }
}
