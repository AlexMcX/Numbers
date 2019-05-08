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

class UIComponent: SKSpriteNode, INJInjectableInstance, INJInjection {
    @objc dynamic internal private(set) var libService: LibraryService!
    @objc dynamic weak public private(set) var mcSize: Sprite?
    
    public var calculateSize: CGSize { return mcSize != nil ? mcSize!.size : calculateAccumulatedFrame().size }
    
    public private(set) var data: Any?
    public enum STATE: String {
        case NONE = ""
        case NORMAL = "normal"
        case DISABLE = "disable"
        case DOWN = "down"
        case OVER = "over"
        case UP = "up"
        case ON = "on"
        case OFF = "off"
    }

    private var currentState: STATE = .NONE
    private var assetName: String = ""
    
    #if DEINIT
    deinit {
        var text = "     ❇️ UIComponent::deinit \"\(self.className)\""
        text += name != nil ? ", with name:\"\(String(describing: name!))\"" : ""
        print(text)
    }
    #else
    #endif
    
    override func onInitialize() {
        updateAssetName("")
        
        onInit()
        
        listeners(true)
    }
    
    override func onDeinitialize() {
        onDispose()
        
        listeners(false)
    }
    
    func onInit() {}
    
    func onDispose() {}
    
    func setData(data: Any?) {
        self.data = data
    }
    
    func validate() {
        
    }
    
    func setState(state: STATE) {
        if(libService == nil) { return }
        
        let asset = assetName.replacingOccurrences(of: "{state}", with: state.rawValue)

        guard let component = libService.getChild(library: "MenuLib", renderer: asset) else {
            return
        }

        let childs = component.children

        component.removeAllChildren(reg: true)
        addChildren(in: childs, reg: true)
    }
    
    func updateAssetName(_ name: String) {
        if (!name.isEmpty && assetName != name) {
            assetName = name

            setState(state: currentState)
        }
    }
    
    func listeners(_ access: Bool) {
        
    }
}
