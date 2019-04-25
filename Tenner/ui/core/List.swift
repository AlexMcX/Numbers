//
//  List.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

/*
        library - *.sks file name
        direction [horizontal, vertical] - direction aling renderers
        renderer - node name in "library"
 */

class List: UIComponent {
    @objc dynamic private var library: String!
    @objc dynamic private var direction: String!
    @objc dynamic private var renderer: String!
    @objc dynamic private var padding: String!
    @objc dynamic private var test: String!
    
    private var paddingComponent: ListItemPaddings?
    private var components: [ListItemRenderer]!
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func onInit() {
        components = []
        
        updateVariables()
    }
    
    public func validate(provider: Array<Any>) {
        var component: ListItemRenderer?
        let componentCLS: ListItemRenderer.Type?
        
        if let renderer = renderer {
            componentCLS = NSClassFromString("\(AppDelegate.IDENTIFIER).\(renderer)") as? ListItemRenderer.Type
            
            for data in provider {
                if (componentCLS != nil) {
                    component = componentCLS!.init()
                }else {
                    component = libService.getChild(library: library, renderer: renderer) as? ListItemRenderer
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
            position.x += CGFloat(paddingComponent?.x ?? 0)
            position.y += CGFloat(paddingComponent?.y ?? 0)

            component.position = position

            switch direction {
                case .none: break
                case .some("horizontal"):
                    position.x -= component.size.width
                case .some("vertical"):
                    position.y -= component.size.height
                default: break
            }
        }
    }
    
    private func updateVariables() {
        if(padding != nil) {
            guard let pd = try? JSONDecoder().decode(ListItemPaddings.self, from: padding.data(using: .utf8)!) else {
                print("List::Error: Couldn't decode padding into ListItemPaddings")
                return
            }
            
            paddingComponent = pd
        }
    }
}
