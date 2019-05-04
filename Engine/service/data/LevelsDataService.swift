//
//  LevelDataService.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection
import CoreData

class LevelsDataService: INJDataService {
    @objc dynamic private var configService: ConfigService!
    
//    private lazy var levelsData: [Level] = { return fetch() as! [Level] }()
//    public lazy var levels: [LevelModel] = { return getLevels() }()
    
    internal var currentID: String?
    internal var currentBlockID: String? {
        didSet {
            if (oldValue != currentBlockID) {
                updateLevels()
            }
        }
    }
    
    public private(set) var levels: [LevelModel] = []
    private var levelsData: [ConfigModel.Level]?
    
    
    override open func onInit() {
        initModel(containerName: "Progress", entityName: "Level", managedObjectClass: Level.self)
    }
    
    public func updateLevels() {
        levels.removeAll()
        levelsData = nil
        
        if let blockID = currentBlockID {
            guard let levelsData = configService.getLevels(id: blockID) else {
                return
            }
            
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
        guard let id = currentID, let result = fetch(unique: "id", value: id) else {
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
    
//    private func getPreviousLevelModel(_ id: String) -> LevelModel? {
//        for (index, level) in levels.enumerated() {
//            if (level.config.id == id) {
//                if(index > 0) {
//                    return levels[index - 1]
//                }
//
//                return nil
//            }
//        }
        
//        return nil
//    }
}
