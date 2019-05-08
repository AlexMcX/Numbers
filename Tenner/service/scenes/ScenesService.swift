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
    
    private var current: SceneIterable!
    private var steps: [String] = []
    private var sequence:[String: (id: SceneIterable, controller: BaseController?)] = [:]
    
    public func setView(view: SKView) {
        self.view = view
    }
    
    public func setScene(scene: SceneIterable) {
        if let current = current {
            if(current.fileName == scene.fileName) { return }
            
            removeScene(current)
        }
        
        self.current = scene
        
        guard let skScene = SKScene(fileNamed: scene.fileName) else { return }
        
        skScene.name = scene.fileName
        skScene.scaleMode = .aspectFill
        
        skScene.initialize()
        
        // init controller to injection
        let controller: BaseController = (scene.controllerClass as BaseController.Type).init(view: skScene as! BaseView)
        controller.onInitialize()
        
        addSequance(scene, controller)
        
        view.presentSceneTo(to: skScene)
    }
    
    public func prevScene() {
        if(steps.count > 0) {
            let id = steps[steps.count - 1]
            
            steps.removeLast()
            
            removeScene(sequence[id]!.id)
            
            if(steps.count > 0) {
                setScene(scene: sequence[steps[steps.count - 1]]!.0)
            }
        }
    }
    
    private func removeScene(_ scene: SceneIterable) {
        guard let controller = sequence[scene.fileName]?.controller else { return }
    
        controller.onDeinitialize()
        
        // controller may not exist "view"
        (controller.view as? SKNode)?.deinitialize()
        
        sequence[scene.fileName]?.controller = nil
    }
    
    private func addSequance(_ scene: SceneIterable, _ controller: BaseController) {
        steps.append(scene.fileName)
        
        sequence[scene.fileName] = (scene, controller)
    }
    
    private func removeStep(_ id: String) {
        guard let index = steps.firstIndex(of: id) else { return }

        steps.remove(at: index)
    }
}
