//
//  List.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

class List: UIComponent {
    @objc dynamic private var direction: UDDirection!
    @objc dynamic private var padding: UDPadding!
    @objc dynamic private var renderer: UDRenderer!
    
    private var components: [ListItemRenderer]!
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func onInit() {
        components = []
    }
    
    public func validate(provider: Array<Any>) {
        var component: ListItemRenderer?
        let componentCLS: ListItemRenderer.Type?
        
        if let renderer = renderer {
            componentCLS = NSClassFromString("\(AppDelegate.IDENTIFIER).\(renderer.renderer!)") as? ListItemRenderer.Type
            
            for data in provider {
                if (componentCLS != nil) {
                    component = componentCLS!.init()
                }else {
                    component = libService.getChild(library: renderer.library!, renderer: renderer.renderer!) as? ListItemRenderer
                }
                
                if (component == nil) { return }
                
                appendRenderer(renderer: component!, data: data)
            }
            
            resize()
        }
    }

    private func appendRenderer(renderer: ListItemRenderer, data: Any? = nil) {
        renderer.setData(data: data)
        
        components.append(renderer)
        
        addChild(renderer)
    }
    
    private func resize() {
        var position: CGPoint = CGPoint(x: 0, y: 0)
        
        for component in components {
            position.x += CGFloat(padding.x ?? 0)
            position.y += CGFloat(padding.y ?? 0)

            component.position = position
            
            switch direction.value {
                case .none: break
                case .horizontal:
                    position.x -= component.size.width
                case .vertical:
                    position.y -= component.size.height
            }
        }
    }
}
