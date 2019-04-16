//
//  MenuScene.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuView: BaseView {
    @objc dynamic weak var playBtn:Button!
    @objc dynamic var controller:MainMenuController!
    
    override func onInit() {
        print("Main menu: \(controller)")
        print("Main menu: \(playBtn)")
    }
}
