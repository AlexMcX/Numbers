//
//  BlockMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
import Foundation
import Engine

class BlocksMenuController: BaseController, ListDelegate {
    @objc dynamic private var engine: Engine!
    
    private lazy var _view: BlocksMenuView = { view as! BlocksMenuView }()
    
    override func onInit() {
        _view.blocks.delegate = self
        
        _view.blocks.validate(provider: engine.getBlocks())
        
        _view.setTotalStars(value: engine.totalStars)
    }
    
    override func onDispose() {
        _view.blocks.delegate = nil
    }
    
    internal func selectItem(data: Any) {
        engine.initBlock(block: data as? BlockModel)
        
        sceneService.setScene(scene: Scene.LevelsMenu)
    }
    
}
