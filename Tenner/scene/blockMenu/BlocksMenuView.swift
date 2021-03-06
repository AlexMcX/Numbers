//
//  BlockMenuView.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import SpriteKit

class BlocksMenuView: BaseView {
    @objc dynamic weak public private(set) var titleTxt: SKLabelNode!
    @objc dynamic weak public private(set) var totalTxt: SKLabelNode!
    @objc dynamic weak public private(set) var blocks: List!
    
    override func onInit() {
        titleTxt.text = NSLocalizedString("BLOCKS_MENU_TITLE", comment: "")
    }
    
    public func setTotalStars(value: Int) {
        let title: String = NSLocalizedString("TOTAL_STARS", comment: "")
        
        totalTxt.text = title.replacingOccurrences(of: "{value}", with: "\(value)")
        
    }
}
