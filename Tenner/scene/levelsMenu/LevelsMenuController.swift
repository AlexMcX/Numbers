//
//  LevelsMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import Engine

class LevelsMenuController: BaseController {
    @objc dynamic private var engine: Engine!
    
    private lazy var _view: LevelsMenuView = { view as! LevelsMenuView }()
    
    override func onInit() {
        _view.levels.validate(provider: engine.getLevels())
        _view.setTotalStars(value: engine.totalStars)
    }
}
