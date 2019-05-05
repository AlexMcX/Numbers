//
//  List.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

class List: UIComponent, ListItemDelegate {
    @objc dynamic private(set) var udDirection: UDDirection!
    @objc dynamic private(set) var udPadding: UDPadding!
    @objc dynamic private(set) var udRenderer: UDRenderer!
    @objc dynamic private(set) var udSize: UDSize!
    
    public var delegate: ListDelegate?
    public var borderSize: CGSize = CGSize()
    public var direction: UDDirection.Direction = .horizontal {
        didSet {
            if (oldValue.rawValue != direction.rawValue) {
                reset()
            }
        }
    }
    
    
    
    private(set) var components: [ListItemRenderer]!
    private var provider: Array<Any>?
    private var container: Sprite!
    private(set) var contentSize: CGSize = CGSize(width: 0, height: 0)
    
    override func onInit() {
        components = []
        
        direction = udDirection?.value ?? .horizontal
        
        borderSize.width = udSize != nil ? CGFloat(udSize!.width!) : mcSize != nil ? mcSize!.calculateSize.width : 0
        borderSize.height = udSize != nil ? CGFloat(udSize!.height!) : mcSize != nil ? mcSize!.calculateSize.height : 0
        
        container = Sprite()
        addChild(container)
    }
        
    public func validate(provider: Array<Any>) {
        validate(provider: provider, position: setPosition)
    }
    
    public func validate(provider: Array<Any>, position: @escaping (ListItemRenderer) ->Bool) {
        self.provider = provider
        
        DispatchQueue.main.async {
            var component: ListItemRenderer?
            let componentCLS: ListItemRenderer.Type?
            
            if let renderer = self.udRenderer {
                componentCLS = NSClassFromString("\(AppDelegate.IDENTIFIER).\(renderer.renderer!)") as? ListItemRenderer.Type
                
                for data in provider {
                    if (componentCLS != nil) {
                        component = componentCLS!.init()
                    }else {
                        component = self.libService.getChild(library: renderer.library!, renderer: renderer.renderer!) as? ListItemRenderer
                    }
                    
                    if (component == nil) { return }
                    
                    if (position(component!) == false) { return }
                    
                    self.appendRenderer(renderer: component!, data: data)
                }
            }
        }
    }
    
    private func setPosition(component: ListItemRenderer) -> Bool {
        if components.count > 0 {
            component.position.x = contentSize.width + CGFloat(udPadding?.x ?? 0)
            component.position.y = -contentSize.height - CGFloat(udPadding?.y ?? 0)
        }
        
        switch direction {
            case .none: return false
            case .horizontal:
                if (borderSize.width < contentSize.width + component.calculateSize.width) {
                    return false
                }

                contentSize.width += component.calculateSize.width
            case .vertical:
                if (borderSize.height < contentSize.height + component.calculateSize.height) {
                    return false
                }

                contentSize.height += component.calculateSize.height
        }
        
        return true
    }
    
    private func reset() {
        if (components.count > 0) {
            print("  🔆 List::reset()")
        }
    }
    
    private func appendRenderer(renderer: ListItemRenderer, data: Any? = nil) {
        renderer.setData(data: data)
        renderer.delegate = self
        
        components.append(renderer)
        
        container.addChild(renderer)
    }
    
    // Mark: ListItemDelegate
    internal func selectItem(item: ListItemRenderer) {
        if let data = item.data {
            delegate?.selectItem(data: data)
        }
    }
}
