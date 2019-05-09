//
//  CheckBox.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

open class CheckBox: UIComponent {
    @objc dynamic weak public private(set) var icon: SKSpriteNode!
    
    public private(set) var onTouch:Signal!;
    
    public var value:Bool = false {
        didSet {
            if oldValue != value {
                updateState()
            }
        }
    }
    
    override open func onInit() {
        onTouch = Signal()
        
        isUserInteractionEnabled = true;
        
        updateState()
    }
    
    private func updateState() {
        if var textureIcon: String = icon.texture?.name {
            textureIcon = textureIcon.slice(to: "_")
            
            icon!.texture = SKTexture(imageNamed: "\(textureIcon)_\(value ? STATE.ON.rawValue: STATE.OFF.rawValue)")
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        value = !value
        
        onTouch.fire()
    }
}
