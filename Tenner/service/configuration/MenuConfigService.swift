//
//  ConfigService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class MenuConfigService: INJFileService {
    @objc dynamic var configModel: MenuConfigModel!
    
    override func onInit() {
        configModel = read(plistFile: "MenuConfig", to: MenuConfigModel.self)
    }
}
