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
        #if TENNER
        print(String(utf8String: getenv("GAME_MODE")) )
        #else
        #endif
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
    
    
    public func getBlocks() -> [BlockModel] {
        return blockDataService.blocks
    }
    
    public func getLevels() -> [LevelModel] {
        return levelsDataService.levels
    }
    
//    public func getLevel() -> GameMode {
//        return levelsDataService.mode
//    }
    
    
    public func isBlockProgress() -> Bool {
        return blockDataService.blocks.count > 1
    }
    
    public func isLevelsProgress() -> Bool {
        return levelsDataService.levels.count > 1
    }
    
    
    #if DEBUG
    public func initBlock(id: String?) {
        for block in getBlocks() {
            if block.data.id == id {
                initBlock(block: block)
            }
        }
    }

    public func initLevel(id: String?) {
        for level in levelsDataService.levels {
            if level.data.id == id {
                initLevel(level: level)
            }
        }
    }
    
    public func initLevel(block: String?, level: String?) {
        initBlock(id: block)
        
        initLevel(id: level)
    }
    #else
    #endif
}
