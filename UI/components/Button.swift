//
//  Button.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

open class Button: UIComponent {
    @objc dynamic weak private var title: SKLabelNode!
    
    public private(set) var onTouch:Signal!;
        
    override open func onInit() {
        onTouch = Signal()
        
        isUserInteractionEnabled = true;
    }
    
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        onTouch.fire()
//        
////        print("   🖱 Button::touchesBegan - \(self.name)")
//    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onTouch.fire()
    }
}
