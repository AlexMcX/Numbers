//
//  UIComponent.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit

open class UIComponent: SKSpriteNode {
    public private(set) var data: ListItemData?
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
        
        injectUserData()
        
        preInit()
        
        onInit()
    }
    
    func onInit() {
        
    }
    
    public func setData(value: ListItemData) {
        data = value
    }
    
    public func validate() {
        
    }
    
    private func preInit() {
        self.size = self.calculateAccumulatedFrame().size
    }
    
    private func injectUserData() {
        guard let data = userData else { return }
        
        let property = Mirror(reflecting: self).children
        
        for item in data {            
            for (key, _) in property {
                if (String(describing: item.key) == key) {
                    setValue(item.value, forKey: key! as String)
                    
                    break
                }
            }
        }
    }
}
