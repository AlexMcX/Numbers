//
//  MainMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class MainMenuController: BaseController {
    @objc dynamic var view: MainMenuView!
    @objc dynamic var sceneService: ScenesService!
    
    override func listeners(access: Bool) {
        if (access) {
            view.playBtn.onTouch.add {
                self.sceneService.setScene(scene: Scene.BlockMenu)
            }
            
            view.optionsBtn.onTouch.add {
                self.sceneService.setScene(scene: Scene.OptionMenu)
            }
        }
    }
}
