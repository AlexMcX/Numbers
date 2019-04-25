//
//  BlockDataService.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection
import CoreData

open class BlockDataService: INJDataService {
    @objc dynamic public private(set) var configService: ConfigService!
    
    private lazy var blocksData: [Block] = { return fetch() as! [Block] }()
    public lazy var blocks: [BlockModel] = { return getBlocks() }()
    
    override open func onInit() {
        initModel(containerName: "Progress", entityName: "Block", managedObjectClass: Block.self)
    }
    
    private func getBlocks() -> [BlockModel] {
        var blockModel: BlockModel
        var result: [BlockModel] = []
        
        for config in configService.getBlocks() {
            blockModel = BlockModel()
            
            blockModel.config = config
            blockModel.data = getBlockData(config.id) ?? createBlockData(config.id)
            
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
    
    private func createBlockData(_ id: String) -> Block? {
        var result: Block;
        
        result = generateObject() as! Block
        
        result.id = id
        
        return result
    }
}

