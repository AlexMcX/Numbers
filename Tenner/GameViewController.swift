//
//  GameViewController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import UIKit
import SpriteKit
import GameplayKit
import DependencyInjection
import Engine

class GameViewController: UIViewController, INJInjection {
    @objc dynamic weak var sceneService: ScenesService!
    @objc dynamic weak var engige: Engine!
        
    public func onInitialize() {
        if let view = self.view as! SKView? {
            engige.initConfig(fileName: "GameConfig")
            
            sceneService.setView(view: view)
            
            sceneService.setScene(scene: Scene.MainMenu)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
//            #if TENNER
//            print(String(utf8String: getenv("GAME_MODE")) )
//            #else
//            #endif
        }
    }
    
    public func onDeinitialize() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        injection()
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
