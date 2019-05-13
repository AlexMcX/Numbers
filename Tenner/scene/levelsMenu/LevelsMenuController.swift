//
//  LevelsMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import Engine
import UI

class LevelsMenuController: BaseController, ListDelegate {
    @objc dynamic private var engine: Engine!
    
    private lazy var _view: LevelsMenuView = { view as! LevelsMenuView }()
    
    override func onInit() {
        _view.levels.delegate = self
        
        _view.levels.validate(provider: engine.levels)
        
        _view.setTotalStars(value: engine.totalStars)
    }
    
    override func onDispose() {
        _view.levels.delegate = nil
    }
    
    func selectItem(data: Any) {
        engine.initLevel(level: data as? LevelModel)
        
        sceneService.setScene(scene: Scene.SceneField)
    }
}
