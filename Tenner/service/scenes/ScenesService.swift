//
//  ScenesService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit
import DependencyInjection

class ScenesService: INJService {
    private var view:SKView!
    private var steps:[SceneIterable] = []
    
    public func setView(view: SKView) {
        self.view = view
    }
    
    public func setScene(scene: SceneIterable) {
        guard let skScene = SKScene(fileNamed: scene.fileName) else { return }
        
        // init controller to injection
        _ = (scene.controllerClass as NSObject.Type).init()
        
        skScene.name = scene.fileName
        skScene.scaleMode = .aspectFill
        
        view.presentSceneTo(to: skScene)
    }
    
    public func prevScene() {
        
    }
    
    private func isPrevScene(_ scene: SceneIterable) -> Bool
    {
        if steps.count > 0 {
            return steps[steps.count - 1].fileName == scene.fileName;
        }
        
        return false;
    }
}
