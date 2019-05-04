//
//  MainMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class MainMenuController: BaseController {
    private lazy var _view: MainMenuView = { view as! MainMenuView }()
    
    override func listeners(access: Bool) {
        if (access) {
            _view.playBtn.onTouch.add {
                self.sceneService.setScene(scene: Scene.BlocksMenu)
            }

            _view.optionsBtn.onTouch.add {
                self.sceneService.setScene(scene: Scene.OptionMenu)
            }
        }else {
            _view.playBtn.onTouch.clear()
            
            _view.optionsBtn.onTouch.clear()
        }
    }
}
