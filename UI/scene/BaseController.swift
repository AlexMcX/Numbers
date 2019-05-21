//
//  Controller.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/16/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

open class BaseController: INJController {
    @objc dynamic public private(set) weak var sceneService: ScenesService!
    
    private lazy var _view: BaseView = { view as! BaseView }()
    
    #if DEINIT
    deinit {
        print("     ❇️ BaseController::deinit \(self.className)")
    }
    #else
    #endif
    
    open override func postInit() {
        listenersBase(true)
        listeners(access: true)
    }
    
    open override func preDispose() {
        listenersBase(false)
        listeners(access: false)
    }
    
    open func listeners(access: Bool) {
        
    }
    
    private func listenersBase(_ access: Bool) {
        if (access) {
            _view.backBtn?.onTouch.add { [unowned self] in
                self.sceneService.prevScene()
            }
        }
    }
    
}
