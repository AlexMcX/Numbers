//
//  BlockMenu.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import Engine

class BlockMenuRenderer: ListItemRenderer {    
    @objc dynamic weak public private(set) var playBtn: Button?
    @objc dynamic weak public private(set) var titleTxt: SKLabelNode!
    @objc dynamic weak public private(set) var needTxt: SKLabelNode?
    @objc dynamic weak public private(set) var starImg_0: SKSpriteNode!
    @objc dynamic weak public private(set) var starImg_1: SKSpriteNode!
    @objc dynamic weak public private(set) var starImg_2: SKSpriteNode!
    
    override func updateAssetName(_ name: String) {
        super.updateAssetName("block_{state}")
    }
    
    override func setData(data: Any?) {
        if let data = data as? BlockModel {
            titleTxt.text = data.config.title
        }
        
        setState(state: .NORMAL)
    }

}
