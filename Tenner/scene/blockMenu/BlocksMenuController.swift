//
//  BlockMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
import Foundation
import Engine

class BlocksMenuController: BaseController {
//    @objc dynamic private var view: BlocksMenuView!
    @objc dynamic private var engine: Engine!
    
    private lazy var _view: BlocksMenuView = { view as! BlocksMenuView }()
    
    override func onInit() {        
        updateBlocks()
    }
    
    private func updateBlocks() {
        _view.blocks.validate(provider: engine.getBlocks())
        
        _view.setTotalStars(value: engine.totalStars)
    }
    
}
