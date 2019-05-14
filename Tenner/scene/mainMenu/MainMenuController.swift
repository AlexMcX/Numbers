//
//  MainMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import Foundation
import Engine

class MainMenuController: BaseController {
    @objc dynamic private var engine: Engine!
    private lazy var _view: MainMenuView = { view as! MainMenuView }()
    
    override func listeners(access: Bool) {
        if (access) {
            _view.playBtn.onTouch.add {  [unowned self] in
                if (self.engine.isBlockProgress) {
                    self.sceneService.setScene(scene: Scene.BlocksMenu)
                }else {
                    self.engine.initBlockFirst()
                    
                    if (self.engine.isLevelsProgress) {
                        self.sceneService.setScene(scene: Scene.LevelsMenu)
                    }else {
                        self.engine.initLevelFirst()
                        
                        self.sceneService.setScene(scene: Scene.SceneField)
                    }
                }
            }

            _view.optionsBtn.onTouch.add { [unowned self] in
                self.sceneService.setScene(scene: Scene.OptionMenu)
            }
        }
    }
}
