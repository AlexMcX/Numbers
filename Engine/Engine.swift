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
    @objc dynamic private var blockDataService: BlocksDataService!
    @objc dynamic private var levelsDataService: LevelsDataService!
    @objc dynamic private var configService: ConfigService!
    
    public var totalStars: Int { return blockDataService.totalStars }
    
    override init() {
        super.init()
        
        injection()
    }
    
    public func onInitialize() {}
    
    public func onDeinitialize() {}
        
    public func initConfig(fileName: String) {
        configService.initConfig(fileName: fileName)
    }
    
    
    public func initBlock(block: BlockModel?) {
        blockDataService.current = block
        levelsDataService.currentBlock = block
    }
    
    public func initLevel(level: LevelModel?) {
        levelsDataService.current = level
    }
    
    
//    public func initBlock(id: String?) {
//        blockDataService.currentID = id
//        levelsDataService.currentBlockID = id
//    }
    
//    public func initLevel(id: String?) {
//        levelsDataService.currentID = id
//    }
    
    public func getBlocks() -> [BlockModel] {
        return blockDataService.blocks
    }
    
    public func getLevels() -> [LevelModel] {
        return levelsDataService.levels
    }
}
