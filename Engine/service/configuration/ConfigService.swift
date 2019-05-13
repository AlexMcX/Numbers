//
//  ConfigurationService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

internal class ConfigService: INJFileService {    
    private var configModel: ConfigModel!
    
    override public func onInit() {
        
    }
    
    public func initConfig(fileName: String) {
        configModel = read(plistFile: fileName, to: ConfigModel.self)
    }
    
    public func getBlocks() -> [ConfigModel.Block] {
        return configModel.blockConfig
    }
}
