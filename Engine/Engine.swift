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
    public var blocks: [BlockModel] { return blockDataService.blocks }
    public var levels: [LevelModel] { return levelsDataService.levels }
    public var field: EGField { return levelsDataService.field }
    public var isBlockProgress: Bool { return blockDataService.blocks.count > 1 }
    public var isLevelsProgress: Bool { return levelsDataService.levels.count > 1 }
    
    override init() {
        super.init()
        
        injection()
//        #if TENNER
//        print(String(utf8String: getenv("GAME_MODE")) )
//        #else
//        #endif
    }
    
    public func onInitialize() {}
    
    public func onDeinitialize() {}
        
    public func initConfig(fileName: String) {
        configService.initConfig(fileName: fileName)
    }
    
    
    public func initBlockFirst() {
        initBlock(block: blockDataService.blocks[0])
    }
    
    public func initLevelFirst() {
        initLevel(level: levelsDataService.levels[0])
    }
    
    public func initBlock(block: BlockModel?) {
        blockDataService.current = block
        levelsDataService.currentBlock = block
    }
    
    public func initLevel(level: LevelModel?) {
        levelsDataService.current = level
    }
}
