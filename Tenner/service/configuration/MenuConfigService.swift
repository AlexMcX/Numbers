//
//  ConfigService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class MenuConfigService: INJDecoderService {
    @objc dynamic var configModel: MenuConfigModel!
    
    override func onInit() {
        configModel = create(plist: "MenuConfig", type: MenuConfigModel.self) as? MenuConfigModel
    }
}
