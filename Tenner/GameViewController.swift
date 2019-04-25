//
//  GameViewController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import DependencyInjection
import Engine

class GameViewController: UIViewController, INJInjection {
    @objc dynamic weak var sceneService: ScenesService!
    @objc dynamic weak var engige: Engine!
    
    func onInit() {
        if let view = self.view as! SKView? {
            engige.initConfig(fileName: "GameConfig")
            
            sceneService.setView(view: view)
            
            sceneService.setScene(scene: Scene.BlockMenu)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let _ = self.view as! SKView? {
//            sceneService.setView(view: view)
            injection()
            
            onInit()
            
            
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "MainMenuScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
            
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
