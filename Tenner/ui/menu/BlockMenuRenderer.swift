//
//  BlockMenu.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import Engine
import UI

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
        super.setData(data: data)
        
        if let data = data as? BlockModel {
            titleTxt.text = NSLocalizedString(data.config.title, comment: "")
         
            if data.access {
                setNormalState(data)
                
                return
            }
            
            setDisableState(data)
        }
    }
    
    override func listeners(_ access: Bool) {        
        if (access) {
            playBtn?.onTouch.add {
                self.delegate?.selectItem(item: self)
            }
        }else {
            playBtn?.onTouch.clear()
        }
    }
    
    private func setNormalState(_ data: BlockModel) {
        setState(state: .NORMAL)
        
        if var textureStar: String = starImg_0.texture?.name {
            let starImg = [starImg_0, starImg_1, starImg_2]
            
            textureStar = textureStar.slice(to: "_")
            
            for (index, star) in starImg.enumerated() {                
                star?.texture = SKTexture(imageNamed: "\(textureStar)_\(index < data.progressStars ? STATE.ON.rawValue: STATE.OFF.rawValue)")
            }
        }
        
        listeners(true)
    }
    
    private func setDisableState(_ data: BlockModel) {
        let needTitle: String = NSLocalizedString("BLOC_MENU_NEED_STARS", comment: "")
        
        setState(state: .DISABLE)
        
        needTxt?.text = needTitle.replacingOccurrences(of: "{value}", with: "\(String(describing: data.unlockStars))")
    }
}
