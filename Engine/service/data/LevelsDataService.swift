//
//  LevelDataService.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection
import CoreData

public class LevelsDataService: INJDataService {
    @objc dynamic private var configService: ConfigService!
    
    internal var current: LevelModel! {didSet {
            if (oldValue != current) {
                field = ClassicField(fileName: current.config.id)
            }
        }
    }
    internal var currentBlock: BlockModel? {
        didSet {
            if (oldValue != currentBlock) {
                updateLevels()
            }
        }
    }
    
    public private(set) var field: Field!
    public private(set) var levels: [LevelModel] = []
    private var levelsData: [ConfigModel.Level]?
    
    
    override open func onInit() {
        initModel(containerName: "Progress", entityName: "Level", managedObjectClass: Level.self)
    }
    
    private func updateLevels() {
        levels.removeAll()
        levelsData = nil
        
        if let levelsData = currentBlock?.config.levels {
            self.levelsData = levelsData
            
            for config in levelsData {
                levels.append(createLevelModel(config))
            }
        }
    }
    
    private func createLevelModel(_ config: ConfigModel.Level) -> LevelModel {
        let result: LevelModel = LevelModel()
        
        result.config = config
        result.data = getLevelData(config.id) ?? createBlockData(config.id)
        result.access = {
            if (levels.count > 0) {
                return levels[levels.count - 1].data.receivedStars > 0
            }
            return true
        }()
        result.progressStars = Int(result.data.receivedStars)
        
        return result
    }
    
    private func getLevelData(_ id: String) -> Level? {
        guard let id = current?.data.id, let result = fetch(unique: "id", value: id) else {
            return nil
        }
        
        if (result.count > 0) {
            return result[0] as? Level
        }
        
        return nil
    }
    
    private func createBlockData(_ id: String) -> Level {
        var result: Level;
        
        result = generateObject() as! Level
        
        result.id = id
        
        return result
    }
    
//    private func updateLevelMode() {
//        switch current.config.type {
//            case "Tenner":
//                _currentMode = Tenner(data: current)
//            case "Swap":
//                _currentMode = Swap(data: current)
//            default: break            
//        }
//    }
}
