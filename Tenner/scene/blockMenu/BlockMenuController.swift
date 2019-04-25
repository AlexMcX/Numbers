//
//  BlockMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
import Foundation
import Engine

class BlockMenuController: BaseController {
    @objc dynamic private var view: BlockMenuView!
    @objc dynamic private var engige: Engine!
    
    override func onInit() {
        updateBlocks()
    }
    
    private func updateBlocks() {
        let data = engige.blockDataService.blocks
        
        view.blocks.validate(provider: data)
    }
    
}
