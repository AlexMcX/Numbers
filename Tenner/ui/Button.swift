//
//  Button.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit
import DependencyInjection

class Button: SKSpriteNode {
    private enum STATE: String {
        case DISABLE = "disable"
        case DOWN = "down"
        case OVER = "over"
        case UP = "up"
    }
    
    private var template:String = ""
    @objc dynamic weak var bg: SKSpriteNode!
    @objc dynamic weak var title: SKLabelNode!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
        
        updateTemplate()
        
        isUserInteractionEnabled = true;
    }
    
    private func updateTemplate() {
        guard let name = bg.texture?.name else { return }
        
        template = name.slice(to: STATE.UP.rawValue)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
//    private func setState(_ state:STATE) {
//        switch state {
//        case .DISABLE:
//        case .DOWN:
//        case .OVER:
//        case .UP
//    }
}
