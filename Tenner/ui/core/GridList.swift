//
//  GridList.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

class GridList: List {
    private var lastPosition: CGPoint = CGPoint()
    
    override func onInit() {
        super.onInit();
        
//        validate(provider: ["0", "1", "2", "3", "4", "5", "6"])
    }
    
    override func validate(provider: Array<Any>) {
        super.validate(provider: provider, position: setPosition)
    }
    
    private func setPosition(component: ListItemRenderer) -> Bool {
        var result: Bool
        
        func updatePosition() {
            component.position.x = lastPosition.x
            component.position.y = -lastPosition.y
        }
        
        switch direction {
            case .none: return false
            case .horizontal:
                result =  horizontalPosition(component)
                
                if(result == true) {
                    updatePosition()
                    
                    lastPosition.x += component.calculateSize.width + CGFloat(udPadding?.x ?? 0)
                }
            case .vertical:
                result = verticalPosition(component)
            
                if(result == true) {
                    updatePosition()
                    
                    lastPosition.y += component.calculateSize.height + CGFloat(udPadding?.y ?? 0)
                }
        }
        
        return result
    }
    
    private func horizontalPosition(_ component: ListItemRenderer) -> Bool {
        if (borderSize.width < lastPosition.x + component.calculateSize.width) {
            lastPosition.x = 0
            
            if (direction == .horizontal) {
                lastPosition.y += component.calculateSize.height + CGFloat(udPadding?.y ?? 0)
            }
            
            return verticalPosition(component)
        }
        
        return true
    }
    
    private func verticalPosition(_ component: ListItemRenderer) -> Bool {
        if (borderSize.height < lastPosition.y + component.calculateSize.height) {
            lastPosition.y = 0
            
            if(direction == .vertical) {
                lastPosition.x += component.calculateSize.width + CGFloat(udPadding?.x ?? 0)
            }
            
            return horizontalPosition(component)
        }
        
        return true
    }
}
