//
//  OptionMenuController.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI

class OptionMenuController: BaseController {
    @objc dynamic private var settings: SettingsService!
    
    private lazy var _view: OptionMenuView = { view as! OptionMenuView }()
    private lazy var settingsModel: Settings = { return settings.settings }()
    
    override func onInit() {
        _view.soundCb.value = settingsModel.sound
        _view.effectCb.value = settingsModel.effect
        _view.helpCb.value = settingsModel.help
    }
    
    override func listeners(access: Bool) {
        if access {
            _view.soundCb.onTouch.add { [unowned self] in
                self.settingsModel.sound = !self.settingsModel.sound
            }
            _view.effectCb.onTouch.add { [unowned self] in
                self.settingsModel.effect = !self.settingsModel.effect
            }
            _view.helpCb.onTouch.add { [unowned self] in
                self.settingsModel.help = !self.settingsModel.help
            }
            _view.languageBtn.onTouch.add { /*[unowned self] in*/
                print("OptionMenuController::change language")
            }
            _view.resetBtn.onTouch.add { /*[unowned self] in*/
                print("OptionMenuController:: reset game")
            }
        }
    }
}
