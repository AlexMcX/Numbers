//
//  Controller.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class BaseController: INJController {
    @objc dynamic weak var sceneService: ScenesService!
    
    private lazy var _view: BaseView = { view as! BaseView }()
    
    #if DEBUG    
    deinit {
        print("     ❇️ BaseController::deinit \(self.className)")
    }
    #else
    #endif
    
    override func postInit() {
        listenersBase(true)
        listeners(access: true)
    }
    
    override func preDispose() {
        listenersBase(false)
        listeners(access: false)
    }
    
    func listeners(access: Bool) {
        
    }
    
    private func listenersBase(_ access: Bool) {
        if (access) {
            _view.backBtn?.onTouch.add {
                self.sceneService.prevScene()
            }
        }else {
            _view.backBtn?.onTouch.clear()
        }
    }
    
}
