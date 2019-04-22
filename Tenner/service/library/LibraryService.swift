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
    
    private var scenes: [String:SKScene] = [:]
    
    public func getChild(library: String, renderer: String) -> SKNode? {
        var lib = scenes[library]
        
        if (lib == nil) {
            lib = SKScene(fileNamed: library);
            
            scenes[library] = lib
        }
        
        if (lib == nil) { return nil }
        
        guard var result = lib?.childNode(withName: renderer) else {
            return nil
        }
        
        result = result.copy() as! SKNode
        
        result.position = CGPoint(x: 0, y: 0)
        
        return result
    }
    
    public func clear() {
        scenes.removeAll()
    }
}
