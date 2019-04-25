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

class Button: UIComponent {
    @objc dynamic weak var title: SKLabelNode!
    @objc dynamic weak var background: SKSpriteNode!
    
    private var template:String = ""
    
    public private(set) var onTouch:Signal!;
        
    override func onInit() {
        onTouch = Signal()
        
        isUserInteractionEnabled = true;
        
        updateTemplate()
    }
    
    
    private func updateTemplate() {
        guard let name = background.texture?.name else { return }
        
        template = name.slice(to: STATE.NONE.rawValue)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onTouch.fire()
    }
}
