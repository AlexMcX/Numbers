//
//  Tile.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/18/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import Engine
import SpriteKit

class Tile: Sprite {
    @objc dynamic weak public private(set) var selectBtn: Button?
    @objc dynamic weak public private(set) var titleTxt: SKLabelNode!
    @objc dynamic weak public private(set) var idTxt: SKLabelNode?
    
    internal private(set) weak var model: EGTileModel?
    
    public weak var delegate: TileDelegate?
    
    public func setModel(_ model: EGTileModel) {
        self.model = model
        
        setState(TileState(rawValue: model.type.rawValue.lowercased())!)
        
        titleTxt.text = String(describing: model.index)
        
        idTxt?.text = String(describing: model.id)
    }
      
    public func clear() {
        self.model = nil
    }
    
    override func listeners(_ access: Bool) {
        if access {
            selectBtn?.onTouch.add { [unowned self] in
                if (self.disable == false) {
                    if (self.model?.isSuccess == true || self.model?.type == EGTypeProbabilityValue.lock) {
                        return
                    }
                    
                    self.selected = !self.selected
                    
                    if (self.selected == false) {
                        self.delegate?.deselesectTile(self)
                    }else {
                       self.delegate?.selectTile(self)
                    }
                }
            }
        }
    }
}

enum TileState: String {
    case normal
    case selected
    case lock
    
}
