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
    @objc dynamic var library: String!
    @objc dynamic var direction: String!
    @objc dynamic var renderer: String!
    @objc dynamic var padding: String!
    @objc dynamic var test: String!
    
    private var paddingComponent: ListItemPaddings?
    private var components: [ListItemRenderer]!
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        print("List::init \(self.debugDescription)")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        print("List::required init \(self.debugDescription)")
    }
    
    override func onInit() {
        components = []
        
        updateVariables()
        
//        print("onInit: \(renderer)  ||      ", self)
        
//        var provider:[BlockListItemData] = []
//
//        for i in 0..<1 {
//            provider.append(BlockListItemData(index: i))
//        }
//
//        validate(provider: provider)
    }
    
    public func validate(provider: Array<Any>) {
        var component: ListItemRenderer?
        let componentCLS: ListItemRenderer.Type?
        
        print("renderer: \(renderer)  ||     ", self)
        
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
        renderer.setData(value: data)
        
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



//class BlockListItemData {
//    var name:String = "Block_1"
//    var stars:Int = 1
//    var needPoints:Int = 2512
//
//    init(index: Int) {
//        name = "Block_\(index)"
//        stars = Int.randomRange(min: 0, max: 3)
//        needPoints = Int.randomRange(min: 1000, max: 2000)
//    }
//}
