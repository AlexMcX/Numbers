//
//  UIComponent.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection
import Engine

open class UIComponent: SKSpriteNode, INJInjectableInstance, INJInjection {
    @objc dynamic public private(set) var libService: LibraryService!
    @objc dynamic weak public private(set) var mcSize: Sprite?
    
    @objc dynamic internal private(set) var libName: String?
    @objc dynamic internal private(set) var renderName: String?
    public var calculateSize: CGSize { return mcSize != nil ? mcSize!.size : calculateAccumulatedFrame().size }
    public var selected: Bool = false {
        didSet {
            if (selected == true) {
                setState(UIComponentState.selected)
            }else {
                if let prev = previousState { setState(prev) }
            }
        }
    }
    public var disable: Bool = false {
        didSet {
            if (disable == true) {
                setState(UIComponentState.selected)
            }else {
                if let prev = previousState { setState(prev) }
            }
        }
    }

    
    public private(set) var data: Any?
    
    private var stateChildren: [SKNode] = []
    private var previousState: String?
    private var currentState: String?
    
    #if DEINIT
    deinit {
        var text = "     ❇️ UIComponent::deinit \"\(self.className)\""
        text += name != nil ? ", with name:\"\(String(describing: name!))\"" : ""
        print(text)
    }
    #endif
    
    override public func onInitialize() {
        onInit()
        
        listeners(true)
    }
    
    override public func onDeinitialize() {
        onDispose()
        
        listeners(false)
    }
    
    open func onInit() {}
    
    open func onDispose() {}
    
    open func setData(data: Any?) {
        self.data = data
    }
    
    open func validate() {
        
    }
    
    open func listeners(_ access: Bool) {
        
    }
    
    open func setState<T: RawRepresentable>(_ state: T) {
        setState(String(describing: state.rawValue))
    }
    
    private func setState(_ state: String) {
        guard   let lib = libName,
            let render = renderName,
            let service = libService else { return }
        
        guard let component = service.getChild(library: lib, renderer: "\(render)_\(state)") else {
            return
        }
        
        removeChildren(in: stateChildren, reg: true)
        
        stateChildren = component.children
        
        component.removeAllChildren(reg: true)
        addChildren(in: stateChildren, reg: true)
        
        previousState = currentState
        currentState = state
    }
}

public enum UIComponentState: String {
    case none
    case normal
    case disable
    case selected
}
