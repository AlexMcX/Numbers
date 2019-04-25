//
//  BlockMenuView.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit

class BlockMenuView: BaseView {
    @objc dynamic weak public private(set) var titleTxt: SKLabelNode!
    @objc dynamic weak public private(set) var totalTxt: SKLabelNode!
    @objc dynamic weak public private(set) var blocks: List!
}
