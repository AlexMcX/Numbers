//
//  BlockMenu.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit

class BlockMenuRenderer: ListItemRenderer {    
    @objc dynamic weak var playBtn: Button?
    @objc dynamic weak var titleTxt: SKLabelNode!
    @objc dynamic weak var needTxt: SKLabelNode?
    @objc dynamic weak var starImg_0: SKSpriteNode!
    @objc dynamic weak var starImg_1: SKSpriteNode!
    @objc dynamic weak var starImg_2: SKSpriteNode!
    
    override func updateAssetName(_ name: String) {
        super.updateAssetName("block_{state}")
    }
    
    override func setData(value: Any?) {
        setState(state: .NORMAL)
        
//        print("-*-*-*-*-*-*-*-*-*-*-*- BlockMenuRenderer:: \(titleTxt)")
//        titleTxt.text = "Block: \(Int.randomRange(min: 0, max: 50))"
        
//        print("BlockMenuRenderer::playBtn \(playBtn)")
    }

}
