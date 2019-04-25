//
//  UIComponent.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

class UIComponent: SKSpriteNode, INJInjection {
    @objc dynamic var libService: LibraryService!
    
    public private(set) var data: Any?
    public enum STATE: String {
        case NONE = ""
        case NORMAL = "normal"
        case DISABLE = "disable"
    }

    private var currentState: STATE = .NONE
    private var assetName: String = ""
    
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        initComponent()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initComponent()
    }
    
    public func initComponent() {
//        injection()
        
//        self.initialize()
        
//        injectUserData()
        
        updateAssetName("")
        
        preInit()
        
        onInit()
    }
    
    public func onInit() {
        
    }
    
    public func setData(value: Any?) {
        data = value
    }
    
    public func validate() {
        
    }
    
    public func setState(state: STATE) {
        let asset = assetName.replacingOccurrences(of: "{state}", with: state.rawValue)
        
        guard let component = libService.getChild(library: "MenuLib", renderer: asset) else {
            return
        }
        
        let childs = component.children
        
        component.removeAllChildren(reg: true)
        addChildren(in: childs, reg: true)
    }
    
    private func preInit() {
        self.size = self.calculateAccumulatedFrame().size
    }
    
//    private func injectUserData() {
//        guard let data = userData else { return }
//
//        let property = Mirror(reflecting: self).children
//
//        for item in data {
//            for (key, _) in property {
//                if (String(describing: item.key) == key) {
//                    setValue(item.value, forKey: key! as String)
//
//                    break
//                }
//            }
//        }
//    }
    
    internal func updateAssetName(_ name: String) {
        if (!name.isEmpty && assetName != name) {
            assetName = name

            setState(state: currentState)
        }
    }
}
