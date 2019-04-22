//
//  ConfigurationService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class ConfigurationService: INJDecoderService {
    @objc dynamic var configModel:ConfigurationModel!
    
    public var blocksCount: Int { return configModel.blockConfig.count}
    
    override func onInit() {
        configModel = create(plist: "Configuration", type: ConfigurationModel.self) as? ConfigurationModel
    }
    
    public func getTitleBlock(index: Int) -> String {
        return configModel.blockConfig[index].title
    }
    
    public func getLevelsCount(block: Int) -> Int {
        return configModel.blockConfig[block].levels.count
    }
}
