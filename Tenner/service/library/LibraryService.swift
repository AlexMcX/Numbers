//
//  LibraryService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import SpriteKit
import DependencyInjection

class LibraryService: INJService {
    private enum STATE {
        case wait, register
    }
    
    private var scenes: [String:(state: STATE, scene: SKScene?)] = [:]
    
    public func getChild(library: String, renderer: String) -> SKNode? {
        var lib: SKScene?
        
        if (renderer.isEmpty) { return nil }
        
        if (scenes[library] == nil) {
            scenes[library] = (STATE.wait, nil)
            
            lib = SKScene(fileNamed: library);
            
            scenes[library]!.scene = lib
            scenes[library]!.state = .register
        }else {
            lib = scenes[library]!.scene
        }
        
        if (lib == nil) { return nil }
        
        guard var result = lib?.childNode(withName: renderer) else {
            return nil
        }
        
        result = result.copy() as! SKNode
        result.initialize()
        
        result.position = CGPoint(x: 0, y: 0)
        
        return result
    }
    
    public func clear() {
        scenes.removeAll()
    }
}
