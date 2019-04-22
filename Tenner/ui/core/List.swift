//
//  List.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

/*
        library - *.sks file name
        direction [horizontal, vertical] - direction aling renderers
        renderer - node name in "library"
 */

class List: UIComponent, INJInjection {
    @objc dynamic var library: String!
    @objc dynamic var direction: String!
    @objc dynamic var renderer: String!
    @objc dynamic var padding: String!
    @objc dynamic var test: String!
    
    @objc dynamic var libService: LibraryService!
    
    private var paddingComponent: ListItemPaddings?
    private var components:[ListItemRenderer] = []
    
    override func onInit() {
        injection()
        
        updateVariables()
        
        
        
        
        var provider:[BlockListItemData] = []

        for i in 0..<3 {
            provider.append(BlockListItemData(index: i))
        }

        validate(provider: provider)
    }
    
    public func validate(provider: Array<ListItemData>) {
        var componentRenderer:String;
        
        for data in provider {
            componentRenderer = renderer
            componentRenderer = componentRenderer.replacingOccurrences(of: "{state}", with: data.state)
            
            guard let component = libService.getChild(library: library, renderer: componentRenderer) as? ListItemRenderer else {
                continue
            }
            
            component.setData(value: data)
            
            components.append(component)
            
            addChild(component)
        }
        
        resize()
    }
    
    private func resize() {
        var position:CGPoint = CGPoint(x: 0, y: 0)
        
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



fileprivate class BlockListItemData: ListItemData {
    var name:String = "Block_1"
    var stars:Int = 1
    var needPoints:Int = 2512
    
    init(index: Int) {
        name = "Block_\(index)"
        stars = Int.randomRange(min: 0, max: 3)
        needPoints = Int.randomRange(min: 1000, max: 2000)
        
        super.init()
        
        state = "normal"
    }
}
