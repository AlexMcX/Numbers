//
//  BlockDataService.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection
import CoreData

open class BlocksDataService: INJDataService {
    @objc dynamic private var configModel: ConfigModel!
    
    private lazy var blocksData: [Block] = { return fetch() as! [Block] }()
    lazy var blocks: [BlockModel] = { return getBlocks() }()
    lazy var totalStars: Int = { return getTotalStars() }()
    
    internal var current: BlockModel?
    
    override open func onInit() {
        initModel(containerName: "Progress", entityName: "Block", managedObjectClass: Block.self)
    }
    
    private func getBlocks() -> [BlockModel] {
        var blockModel: BlockModel
        var result: [BlockModel] = []
        
        for config in configModel.blockConfig {
            blockModel = BlockModel()
            
            blockModel.config = config
            blockModel.data = getBlockData(config.id) ?? createBlockData(config.id)
            blockModel.unlockStars = config.unlockStars
            blockModel.access = config.unlockStars <= totalStars
            blockModel.progressStars = Int(blockModel.data.receivedStars)  / config.levels.count
            
            result.append(blockModel)
        }
        
        return result
    }
    
    private func getBlockData(_ id: String) -> Block? {
        for data in blocksData {
            if (data.id == id) {
                return data
            }
        }
        
        return nil
    }
    
    private func createBlockData(_ id: String) -> Block {
        var result: Block;
        
        result = generateObject() as! Block
        
        result.id = id
        
        return result
    }
    
    private func getTotalStars() -> Int {
        var result = 0
        
        for block in blocksData {
            result += Int(block.receivedStars)
        }
        
        return result
    }
}

